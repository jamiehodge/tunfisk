DefaultQueue  = QC.default_queue
FailedQueue   = QC::Queue.new 'queue_classic_failed_jobs'

class Worker < QC::Worker
  def handle_failure(job, exception)
    FailedQueue.enqueue job[:method], *job[:args]
  end
end
