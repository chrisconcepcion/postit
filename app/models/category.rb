class Category < ActiveRecord::Base
	has_many :post_categories
	has_many :posts, through: :post_categories

	validates :name, presence: true, uniqueness: true

		after_validation :generate_slug
	 
	  def generate_slug
	    if self.errors.empty?
	#strip the string
	      slug = self.name.dup

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
	      test = nil
	      test = Post.where("slug = ?",final_slug).first

	#test = Post.find_by_slug(self.slug)
	      while test && (self.new_record? || test != self)
	          count += 1
	          final_slug = slug + "_" + count.to_s

	          test = nil
	          test = Post.where("slug = ?",final_slug).first

	#test = Post.find_by_slug(self.slug)
	      end
	      self.slug = final_slug
	    end
	  end
	  def to_param
	    self.slug
	  end

end