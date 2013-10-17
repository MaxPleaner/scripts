class NotesController < ApplicationController
  # Find requested note
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  before_action :can_delete, only: [:destroy]
  skip_before_action :require_login, :only => [:landing]
  # Make sure user has privilege to show, edit, update or destroy a particular note
  before_action :validate_user
  # Index page already shows user the notes they have permission to view
  skip_before_action :validate_user, :only => [:index, :landing, :new, :create]

  # GET /notes
  # GET /notes.json
  def index
    # only show user their notes when they view all notes
    # search within these notes if the user enters a search query
    @notes = current_user.notes.search(params[:search])

  end

  def landing
  end

  # GET /notes/1
  # GET /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  # POST /notes.json
  def create
    @note = Note.new(note_params)
    @users = User.where(:id => params[:shared_with])
    # add the author as a user
    @users << User.find(note_params[:author_id])
    respond_to do |format|
      if @note.save
        # Add all users the note is shared with to @note.users
        @note.users << @users
        format.html { redirect_to @note, notice: 'Note was successfully created.' }
        format.json { render action: 'show', status: :created, location: @note }
      else
        format.html { render action: 'new' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1
  # PATCH/PUT /notes/1.json

  def update
    # Only the creators of the note may choose who to share the note with
    # Dissociate the current users the note is shared with 

    respond_to do |format|
      if @note.update(note_params)
        if params[:shared_with]
          #Remove all sharees
          @note.users.destroy_all
          # Update with most current list of users to share note with 
          @users = User.where(:id => params[:shared_with])
          # Add curren_user so they will show up in shared list when viewed by other sharees 
          @users << User.find(note_params[:author_id])
          @note.users << @users
        end
        format.html { redirect_to @note, notice: 'Note was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url }
      format.json { head :no_content }
    end
  end

  # Function to validate that user has permission to view a particular note
  # Checks if the user_id associated with the requested note matches the user_id of the logged in user
  # Or if user is a sharee of the note resource
  # Redirects to users notes page if permission denied
  def validate_user
    unless @note.author_id == session[:user_id] || @note.users.include?(@current_user)
      flash[:notice] = "You don't have permission to access this note!"
      redirect_to notes_path
    end
  end

  def can_delete
    unless @note.author_id == session[:user_id]
      flash[:notice] = "You don't have permission to delete this note!"
      redirect_to notes_path
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_params
      params.require(:note).permit(:description, :title, :priority, :author_id, :shared_with)
    end
end
