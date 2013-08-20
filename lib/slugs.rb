module Slugs
  def generate_slug(slugged)
      if self.errors.empty?
  #strip the string
        slug = slugged.dup

  #blow away apostrophes
        slug.gsub! /['`]/,""

  # @ --> at, and & --> and
        slug.gsub! /\s*@\s*/, " at "
        slug.gsub! /\s*&\s*/, " and "

  #replace all non alphanumeric, underscore or periods with underscore
        slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'  

  #convert double underscores to single
        slug.gsub! /_+/,"_"

  #strip off leading/trailing underscore
        slug.gsub! /\A[_\.]+|[_\.]+\z/,""

        slug.downcase!

        count = 0
        final_slug = slug
        self.slug = final_slug
      end
    end

      def to_param
      self.slug
    end
end