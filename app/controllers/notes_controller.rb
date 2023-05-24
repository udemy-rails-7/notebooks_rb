class NotesController < ApplicationController
    before_action :set_note, only: %i[ show edit update destroy ]
    # validate user is logged in
    before_action :authenticate_user!
    def index
        @notes = Note.all
    end
    def show
    end
    def new
        @note = Note.new
    end
    def create
        @note = Note.new(note_params)
        if @note.save
            redirect_to @note, notice: "Note was successfully created."
        else
            render :new, status: :unprocessable_entity
        end
    end
    def edit
    end
    def update
        if @note.update(note_params)
            redirect_to @note, notice: "Note was successfully updated."
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @note.destroy
        redirect_to notes_url, notice: "Note was successfully destroyed."
    end
    private
    def note_params
        params.require(:note).permit(:title, :content, :user_id)
    end
    private
    def set_note
        @note = Note.find(params[:id])
    end
end
