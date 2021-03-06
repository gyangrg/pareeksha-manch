class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    @subjects = Subject.all
    @chapters = Chapter.all
    @topics = Topic.all
    @sub_topics = SubTopic.all
  end

  # GET /questions/1/edit
  def edit
    @question = Question.where(id: params[:id]).first
    # @selected_subject = @question.subject.name
    # @selected_chapter = question.chapter.name
    # @selected_topic = question.topic.name
    # @selected_sub_topic = question.sub_topic.name
    @subjects = Subject.all
    @chapters = Chapter.all
    @topics = Topic.all
    @sub_topics = SubTopic.all
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.create(question_params)

    @question.subject = Subject.find(params[:subject])
    @question.chapter = Chapter.find(params[:chapter])
    @question.topic = Topic.find(params[:topic])
    @question.sub_topic = SubTopic.find(params[:sub_topic])

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update_attributes(question_params)
        @question.subject = Subject.find(params[:subject])
        @question.chapter = Chapter.find(params[:chapter])
        @question.topic = Topic.find(params[:topic])
        @question.sub_topic = SubTopic.find(params[:sub_topic])
        @question.save

        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def question_params
    params.require(:question).permit(:content, :qns_type, :solution, :difficulty, :option1, :option2, :option3, :option4, :solution)
  end
end
