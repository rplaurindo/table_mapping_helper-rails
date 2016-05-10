LIB_PATH = File.expand_path "../../lib", __FILE__
MONKEY_PATCHES_PATH = "#{LIB_PATH}/db_utils/support/monkey_patches"

module DBUtils

  # :: defines declaration to doesn't nesting to DBUtils module
  module ::Rails
    class Application

      # load tasks
      rake_tasks do
        Dir[File.join(LIB_PATH, "tasks", "**/*.rake")].each do |file|
          load file
        end

        Dir[File.join(MONKEY_PATCHES_PATH, "**/*.rake")].each do |file|
          load file
        end
      end

    end
  end

  class Application < ::Rails::Application

  end

  class Railtie < ::Rails::Railtie

    Dir[File.join(MONKEY_PATCHES_PATH, "rails", "**/*.rb")].each do |file|
      require file
    end

    config.after_initialize do
      Dir[File.join(LIB_PATH, "**/*.rb")].each do |file|
        require file
      end
    end

  end

end