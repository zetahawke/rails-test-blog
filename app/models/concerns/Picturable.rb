module Picturable
	extend ActiveSupport::Concern
	included do
		after_save :save_image
	end

	#if self.respond_to?(:name)
	FILE_PATH = File.join Rails.root, "public", "files" #, "attachments"
	#else
	#	FILE_PATH = File.join Rails.root, "public", "files", "posts"
	#end
	

	def file=(file)
		unless file.blank?
			@file = file
			if self.respond_to?(:name)
				self.name = file.original_filename.split(".").first.downcase
			end
			self.extension = file.original_filename.split(".").last.downcase
		end
	end

	def image_path
		File.join FILE_PATH, "#{self.id}.#{self.extension}"
	end

	def had_file?
		File.exists? image_path
	end

	private
	def save_image
		if @file
			FileUtils.mkdir_p FILE_PATH
			File.open(image_path, "wb") do |f|
				f.write(@file.read)
			end
			@file = nil
		end
	end
end