module VMC
  class Cli
    desc "target [url]", "Reports current target or sets a new target"

    def target(url=nil)
      return say("Current target is #{config.target}.", :green) unless url
      config.update(:target, url)
      say "Target set to #{url}.", :green
    end
  end
end
