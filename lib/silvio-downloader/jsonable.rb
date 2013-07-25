require 'json'

module SilvioDownloader
  class JSONable
    def to_json(options = {})
        hash = {}
        self.instance_variables.each do |var|
            hash[var.to_s.gsub(/@/,'').to_sym] = self.instance_variable_get var
        end
        JSON.pretty_generate(hash)
    end
    def from_json! string
        JSON.load(string).each do |var, val|
            self.instance_variable_set var, val
        end
    end
  end
end