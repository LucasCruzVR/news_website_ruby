require 'image_processing/mini_magick'
module AwsRequests
  class SendImageAwsService < ApplicationService
    def initialize(publication:, image_file:) # rubocop:disable Lint/MissingSuper
      @publication = publication
      @image = image_file
    end

    def call
      title_formatted = @publication.title.gsub(' ', '-')
      image_name = "#{title_formatted}-#{rand(0..100)}.jpg"
      @publication.image = "https://news-website-ruby.s3.amazonaws.com/#{image_name}"
      file = ImageProcessing::MiniMagick
             .source(@image)
             .resize_to_limit(1920, 1080)
             .convert('png').call
      object_aws = Aws::S3::Client.new(region: 'us-east-1')
      send_image?(object_aws, 'news-website-ruby', image_name, file)
    end

    private

    def send_image?(object_aws, bucket_name, image_name, file)
      response = object_aws.put_object(
        bucket: bucket_name,
        key: image_name,
        body: file
      )
      if response.etag
        "https://news-website-ruby.s3.amazonaws.com/#{image_name}"
      end
    end
  end
end
