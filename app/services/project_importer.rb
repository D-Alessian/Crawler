require 'csv'
class ProjectImporter
  Field = Struct.new(:header, :attr, :type, :website_type) do
    def cast(value)
      return if value.nil? || value.strip.empty?
      case type
      when :string  then value == 'N/A' ? nil : value.to_s
      when :integer then Integer(value) rescue nil
      when :boolean then %w[yes y true 1].include?(value.strip.downcase)
      when :date    then Date.parse(value) rescue nil
      else value
      end
    end
  end

  PROJECT_FIELDS = [
    Field.new("company name", :name,         :string),
    Field.new("member Y/N",     :is_member,       :boolean),
    Field.new("date added",  :date_started_tracking, :date)
  ]

  PAGE_FIELDS = [
    Field.new("projects page", :projects_page_url, :string, :projects),
    Field.new("jobs page",     :jobs_page_url,     :string, :jobs),
    Field.new("news page",     :news_page_url,     :string, :news),
    Field.new("LinkedIn page", :linkedin_page_url, :string, :linkedin),
  ]

  def self.run(path)
    errors, count = [], 0

    CSV.foreach(path, headers: true).with_index(2) do |row, line|
      project_attrs = PROJECT_FIELDS.each_with_object({}) do |field, attributes|
        attributes[field.attr] = field.cast(row[field.header])
      end

      project = Project.new(project_attrs)
      if project.save
        PAGE_FIELDS.each do |field|
          url = field.cast(row[field.header])
          puts url
          next unless url

          project.websites.create!(
            website_type: Website.website_types[field.website_type],
            url:          url
          )
        end

        count += 1
      else
        errors << { line: line, messages: project.errors.full_messages }
      end
    end

    { count: count, errors: errors }
  end
end
