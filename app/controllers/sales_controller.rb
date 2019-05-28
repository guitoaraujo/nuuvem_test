class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  def index
    @sales = Sale.all
    @total = params[:total]
  end

  def show
  end

  def new
    @sale = Sale.new
  end

  def file_import
    begin
      raise 'File not found!!' if params[:file].blank?
      file = read_file
      total = create_sales_by_file(file)
      redirect_to sales_path(total: total), notice: 'Sales uploaded successfully'
    rescue StandardError => e
      redirect_to sales_path, notice: "#{e.message} Please verify the file and try again."
    end
  end

  def edit
  end

  def create
    @sale = Sale.new(sale_params)

    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Sale was successfully created.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @sale.update(sale_params)
        format.html { redirect_to @sale, notice: 'Sale was successfully updated.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Sale was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def read_file
      File.read(params[:file].tempfile) do |file|
        file.each do |line|
          line
        end
      end
    end

    def create_sales_by_file(file)
      csv = CSV.new(file, col_sep: "\t", headers: true)
      total = 0
      csv.each do |row|
        sale = row.to_h
        total += (sale['item price'].to_f * sale['purchase count'].to_i)
        Sale.create(
            purchaser_name: sale['purchaser name'],
            item_description: sale['item description'],
            item_price: sale['item price'].to_f,
            purchase_count: sale['purchase count'].to_i,
            merchant_address: sale['merchant address'],
            merchant_name: sale['merchant name']
        )
      end
      total
    end

    def set_sale
      @sale = Sale.find(params[:id])
    end

    def sale_params
      params.require(:sale).permit(
          :purchaser_name,
          :item_description,
          :item_price,
          :purchase_count,
          :merchant_address,
          :merchant_name)
    end
end
