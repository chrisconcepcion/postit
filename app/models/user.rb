class User < ActiveRecord::Base

	has_many :posts
	has_many :comments
	has_many :votes

	has_secure_password validations: false
	validates :username, presence: true, uniqueness: true 
	validates :password, presence: true, length: {minimum: 5}
	validates :password, presence: true, length: {minimum: 5}
	after_validation :generate_slug

	def two_factor_auth?
		self.phone.present?
	end

	def generate_pin!
		self.update_column(:pin, rand(10 ** 6)) 
	end

	def remove_pin!
		self.update_column(:pin, nil)
	end

	def send_pin_to_twilio
		account_sid = 'ACcf2d413f36b0b86f5c0245c357820c56'
		auth_token = 'fe9d66d81a29e70ca6e077951f6d126e'

		# set up a client to talk to the Twilio REST API
		client = Twilio::REST::Client.new(account_sid, auth_token)

		msg = "Please input the pin to continue login, pin: #{self.pin}"
		account = client.account
		message = account.sms.messages.create({:from => '+17162010914', :to => self.phone, :body => msg})
	end

	def admin?
		self.role == 'admin'
	end

	def already_voted_on?(obj)
		self.votes.where(voteable: obj).size > 0
	end

	def generate_slug
	    if self.errors.empty?
	#strip the string
	      slug = self.username.dup

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