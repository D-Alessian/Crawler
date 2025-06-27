module Crawler
    class Parser 
        HTML_ATTRS_TO_IGNORE = %w[script style link[rel="stylesheet"] noscript iframe nav navbar]

        def self.clean_html(html)
            return nil unless html

            doc = Nokogiri::HTML(html)
            doc.search(HTML_ATTRS_TO_IGNORE.join(', ')).remove

            # Remove top-level header and footer elements, as well as any header/footer inside a div for situations like '<div id=inner-body>'
            doc.xpath('/html/body/header').remove
            doc.xpath('/html/body/footer').remove
            doc.xpath('/html/body/div/header').remove
            doc.xpath('/html/body/div/footer').remove

            doc.xpath('//comment()').remove

            doc.traverse do |node|
                next unless node.element?
                node.attribute_nodes.each { |attr| node.remove_attribute(attr.name) unless attr.name == 'href' }
            end

            body_elem = doc.at('body') || doc
            texts = body_elem.xpath('.//text()').map(&:text).map(&:strip).reject(&:empty?)
            texts.join("\n")
        end
    end
end