class BaseService
  def self.perform(params)
    instance = self.new(params)
    instance.process
  end
end