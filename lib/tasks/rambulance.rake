namespace :rambulance do
  desc "Precompiles static HTML files for each error status"
  task precompile: :environment do
    exceptions_app = begin
                       ::ExceptionsApp
                     rescue NameError
                       Rambulance::ExceptionsApp
                     end

    exceptions_app.precompile!
  end
end
