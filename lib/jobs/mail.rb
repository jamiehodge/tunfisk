module Job
  class Mail
    
    def self.enqueue(options)
      DefaultQueue.enqueue 'Job::Email.perform', options
    end
    
    def self.perform(options)
      new(options).perform
    end
    
    def initialize(mailer=Pony, options)
      @mailer  = mailer
      @to      = options['to']
      @from    = options['from']
      @subject = options['subject']
      @body    = options['body']
    end
    
    def perform
      @mailer.mail to: @to, from: @from, subject: @subject, body: @body
    end
  end
end
