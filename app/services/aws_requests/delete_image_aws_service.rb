module AwsRequests
  class DeleteImageAwsService < ApplicationService
    def initialize(publication:) # rubocop:disable Lint/MissingSuper
      @publication = publication
    end

    def call
      s3 = Aws::S3::Client.new(region: 'us-east-1')
      @publication.image.slice!('https://news-website-ruby.s3.amazonaws.com/') if @publication.image.present?
      begin
        s3.delete_object(bucket: 'news-website-ruby', key: @publication.image)
      rescue ArgumentError
        ["Couldn't find any file with this name."]
      end
    end
  end
end
