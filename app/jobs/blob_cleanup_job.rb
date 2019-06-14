
class BlobCleanupJob < ApplicationJob

  @queue = :blob_cleanup_job_queue

  def self.perform()
    attachment_blob_ids = ActiveStorage::Attachment.all.map(&:blob_id)
    ActiveStorage::Blob.where.not(id: attachment_blob_ids).each do |blob|
      blob.purge
    end


  end
end
