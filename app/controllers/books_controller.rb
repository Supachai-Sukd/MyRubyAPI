class BooksController < ApplicationController

  # ตัวอย่าง Request body หากใช้ book_params
  # {
  #   "book": {
  #     "name": "soon to be programmer",
  #     "description": "learn programming",
  #     "pages": 256,
  #     "author": "Bank"
  #   }
  # }

   # Rails จะใ้ช้ Strong Params ซึ่งพึ่งพา First level key ตามชื่อของ Model เช่น 
   # book เป็น Standard การดึงค่าจาก request body และจะเช็คค่าข้างใน
   # ฉะนั้นใน Request นี้ params[:book][:author] จะถูกดึงออก เพราะไม่ตรงกับ permit list 
   # ใน book_params


   # จังหวะ Save นั้นก็มี IF เพื่อเช็คว่า save ผ่านหรือไม่ ถ้าผ่านค่อย render json: @book



  # คำสั่งพิเศษบอกให้รัน method set_book ก่อนที่จะรัน show update destroy ทุกครั้ง
  # set_book มีหน้าที่ค้นหา book จาก param[:id] โดยให้ใช้ variable @book 
  # ในความพิเศษของ @book คือเป็น instance ของ Controller object นี้ ทำให้
  # method อื่นๆสามารถเรียกใช้ @book หลังจาก method นี้ถูกเรียกได้
  # ซึ่งทำให้เราไม่จำเป็นต้องเขียน Book.find(params[:id]) ซ้ำบ่อยๆทุก method 
  before_action :set_book, only: %i[ show update destroy ]

  # GET /books
  def index
    # เหมือนเขียนเองแต่ที่ต่างคือ render json: @book ซึ่งไม่มีคำสั่ง .as_json 
    # แต่ rails รู้ว่า @books เป็น serializable จึงทำการ .as_json ให้อัติโนมัติ
    @books = Book.all

    render json: @books
  end

  # GET /books/1
  def show
    # เหตุผล @book เหมือน index
    render json: @book
  end

  # POST /books
  def create
    # book_params อยู่ข้างล่างตรง private เราไปเรียกมาใช้
    # โดย private book_params จากข้างล่างมันจะดึงหา key ที่ชื่อ :book
    # และตรวจดูว่ามี :name. :description, :pages ไหม หากมีให้ดึงออกมา หากไม่มีจะไม่เช็คค่า
    # หรือถ้า key เกินจะตัดทิ้งไป
    @book = Book.new(book_params)

    # เช็คว่า save ผ่านหรือไม่
    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /books/1
  def update
     # เช็คว่า update ผ่านหรือไม่
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  # ลบอย่างเดียว No render
  def destroy
    @book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:name, :description, :pages)
    end
end
