class PeopleController < ApplicationController
  before_action :set_person, only: [:show, :edit, :update, :destroy]

  def index
    @people = Person.all
  end


  def show
  end

  def new
    @person = Person.new
  end

  def edit
  end

  def create
    @person = Person.new(person_params)
    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: 'Person was successfully created.' }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

###########################################################################################################
  def update
    person_with_id = Person.find params[:id]
    if lock_status(person_with_id) == false
        lock_update(params[:id],true)
        
        puts "now is available_____+_+_+_+_+ "

        person_with_id.update_attribute(:name,"tareq")
        sleep 60
        lock_update(params[:id],false)


     else
       redirect_to root_path, notice: "the DB now update please wait"
       puts "is======================> busy "
    end
  end

  def lock_update(id,status)
    person =Person.find id
    person.update_attribute(:busy,status)
  end

  def lock_status(person_with_id)
  if person_with_id.busy == false
    puts"============== the value false"
     return false
  else
    puts"============== the value true========"
    return true
  end
  end



  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: 'Person was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


    # Never trust parameters from the scary internet, only allow the white list through.
    def person_params
      params.require(:person).permit(:name, :busy)
    end
end
