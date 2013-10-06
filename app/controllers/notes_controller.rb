class NotesController < ApplicationController
  # Find requested note
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, :only => [:landing]
  # Make sure user has privilege to show, edit, update or destroy a particular note
  before_action :validate_user
  # Index page already shows user the notes they have permission to view
  skip_before_action :validate_user, :only => [:index, :landing, :new, :create]

  # GET /notes
  # GET /notes.json
  def index
    # only show user their notes when they view all notes
    @notes = current_user.notes
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
    respond_to do |format|
      if @note.save
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
    respond_to do |format|
      if @note.update(note_params)
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

  # Function to validate that user has permission to access a particular note
  # Checks if the user_id associated with the requested note matches the user_id of the logged in user
  # Redirects to users notes page if permission denied
  def validate_user
    unless @note.user_id == session[:user_id]
      flash[:notice] = "You don't have permission to access this note!"
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
      params.require(:note).permit(:description, :title, :priority, :user_id)
    end
end
