# app/services/website_importer.rb
require 'csv'
class WebsiteImporter
  Field = Struct.new(:header, :attr, :type) do
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

  FIELDS = [
    Field.new("company name", :name,         :string),
    Field.new("member Y/N",     :member,       :boolean),
    Field.new("projects page",  :projectsPage,:string),
    Field.new("jobs page",      :jobsPage,    :string),
    Field.new("news page",      :newsPage,    :string),
    Field.new("LinkedIn page",  :linkedinPage,:string),
    Field.new("date added",     :start_date,   :date)
  ]

  def self.run(path)
    errors, count = [], 0
    CSV.foreach(path, headers: true).with_index(2) do |row, line|
      attrs = FIELDS.each_with_object({}) do |f, h|
        h[f.attr] = f.cast(row[f.header])
      end
      site = Website.new(attrs)
      if site.save
        count += 1
      else
        errors << { line: line, messages: site.errors.full_messages }
      end
    end
    Crawler::Processor.first_seed_all if count > 0
    { count: count, errors: errors }
  end
end
