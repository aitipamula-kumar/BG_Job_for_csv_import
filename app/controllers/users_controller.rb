class UsersController < ApplicationController
  require "csv"
  before_action :set_user, only: %i[ show edit update destroy ]

  def import
    # CheckingJob.perform_now(params[:file])
    # puts "hi"
    
    
    file = params[:file]
    return redirect_to users_path, notice: "only csv please" unless file.content_type == 'text/csv'
    file =File.open(file)
    csv = CSV.parse(file, headers: true)
    csv.each {|row| p row
    user_hash = {}
    user_hash[:firstname] = row["firstname"]
    user_hash[:lastname] = row["lastname"]
    # User.create(user_hash)
    CheckingJob.perform_now(user_hash)
      # binding.b
    }
    redirect_to users_path, notice: "Users Imported!"
  end
 

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:firstname, :lastname)
    end
end
