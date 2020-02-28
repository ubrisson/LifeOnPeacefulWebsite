class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]

  # GET /quotes
  def index
    @quote = Quote.new
    @quotes = search_and_tagged_quotes(params).paginate(page: params[:page])
  end

  # GET /quotes/1
  def show
  end

  # GET /quotes/new
  def new
    @quote = Quote.new
  end

  # GET /quotes/1/edit
  def edit
  end

  # POST /quotes
  def create
    @quote = Quote.new(quote_params)

    if @quote.save
      redirect_to @quote, notice: 'Quote was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /quotes/1
  def update
    if @quote.update(quote_params)
      redirect_to @quote, notice: 'Quote was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /quotes/1
  def destroy
    @quote.destroy
    redirect_to quotes_url, notice: 'Quote was successfully destroyed.'
  end

  def export
    @quotes = search_and_tagged_quotes(params)
    send_data @quotes.to_json, filename: "quotes_#{params[:q]}.json",
              type: :json
  end

  def import
    quotes = JSON.parse(File.read(params[:json]))
    quotes.each do |quote|
      Quote.create(quote.to_h)
    end
    flash[:success] = 'Quotes imported'
    redirect_back(fallback_location: quotes_path)
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_quote
    @quote = Quote.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def quote_params
    params.require(:quote).permit(:title, :author, :body, :source,
                                  :tag_list, :commentary, :public)
  end

  def correct_quotes
    logged_in? ? Quote.all : Quote.only_public
  end

  def search_and_tagged_quotes(params)
    if params[:q]
      tagged = correct_quotes.tagged_with(params[:q]).unscope(:order)
      searched = correct_quotes.search_for(params[:q]).unscope(:order)
      correct_quotes
          .from("(#{tagged.to_sql} UNION #{searched.to_sql}) as Quotes")
    elsif params[:tag]
      correct_quotes.tagged_with(params[:tag])
    else
      correct_quotes
    end
  end
end
