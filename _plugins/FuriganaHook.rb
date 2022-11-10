require "jekyll"

module Jekyll
    class HookFurigana
        class << self
            def makeFurigana(doc)
                return doc unless furi?(doc)
                doc.output.gsub!(/(\(\()(.+?)(:|：)(.+?)(\)\))/, "<ruby><rb>\\2</rb><rp>(</rp><rt>\\4</rt><rp>)</rp></ruby>")
                return doc
            end

            def furi?(doc)
                (doc.is_a?(Jekyll::Page) || doc.write?) &&
                  doc.output_ext == ".html" || doc.permalink&.end_with?("/")
            end
        end
    end
end

Jekyll::Hooks.register [:pages, :documents], :post_render do |doc|
    Jekyll::HookFurigana.makeFurigana(doc) if Jekyll::HookFurigana.furi?(doc)
end