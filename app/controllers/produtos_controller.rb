class ProdutosController < ApplicationController
	
	before_action :set_produto, only: [:edit, :update, :destroy]

	def index
		@produtos_por_nome  = Produto.order(:nome).limit(5)
		@produtos_por_preco  = Produto.order(:preco).limit(2) 
	end

	def new # mostrar pag para criar
    	@produto = Produto.new
    	renderiza_new
	end

	def create # criar um produto
	    @produto = Produto.new produto_params
	    if @produto.save
	        flash[:notice] = "Produto salvo com sucesso"
	        redirect_to root_url
	    else
	        renderiza_new
	    end
	end

	def destroy # deletar um produto
		@produto.destroy
		redirect_to root_url
	end

	def edit # mostrar pagina para atualizar
		renderiza_new
	end

	def update # atualizar produto
		valores = produto_params
		@produto.update(valores)
		if @produto.update(valores)
			flash[:notice] = "Produto atualizado com sucesso"
			redirect_to root_url
		else
			renderiza_new
		end
	end

	def busca # busca no header
		nome_a_buscar = "%#{params[:nome]}%"
    	@produtos = Produto.where "nome like ?", nome_a_buscar
	end

	private

	def renderiza_new
		@departamentos = Departamento.all
		render :new
	end

	def set_produto
		id = params[:id]
		@produto = Produto.find(id)
	end

	def produto_params
		params.require(:produto).permit :nome, :preco, :descricao, :quantidade, :departamento_id
	end
end
