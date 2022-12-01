class CheckingJob < ApplicationJob
  queue_as :default

  def perform(*args)
    User.create(args)
   

    
    # file = params[:File]
    # return redirect_to users_path, notice: "only csv please" unless file.content_type == 'text/csv'
    # file =File.open(file)
    # csv = CSV.parse(file, headers: true)
    # csv.each {|row| p row
    # user_hash = {}
    # user_hash[:firstname] = row["firstname"]
    # user_hash[:lastname] = row["lastname"]
    # User.create(user_hash)
    #   # binding.b
    # }
  end
end
 