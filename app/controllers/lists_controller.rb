class ListsController < ApplicationController
  def new
    # Viewへ渡すためのインスタンス変数空のModelオブジェクトを生成する
    @list = List.new
  end

  def create
    # データを受け取り新規作成するためのインスタンス作成
    @list = List.new(list_params)
    # データをデータベースに保存するためのsaveメソッド実行
    if @list.save
    # フラッシュメッセージを定義し、詳細画面へリダイレクト
      flash[:notice] = "投稿に成功しました"
      redirect_to list_path(@list.id)
    else
      # フラッシュメッセージを定義し、new.html.erbを描写する
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  def destroy
    list = List.find(params[:id]) #データ（レコード）を一件収得する
    list.destroy #データ（レコード）を削除する
    redirect_to '/lists' #投稿一覧画面へリダイレクト
  end

  private
  # ストロングパラメーター
  def list_params
    params.require(:list).permit(:title, :body, :image)
  end
end
