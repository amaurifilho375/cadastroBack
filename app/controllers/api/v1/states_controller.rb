module Api::V1
  class StatesController < ApplicationController
    before_action :set_state, only: [:show, :update, :destroy]

     require 'rest-client'
     require 'json'  # ja vem no pacote do rails

    #uri = 'https://servicodados.ibge.gov.br/api/v1/localidades/distritos'


    # GET /states
    def index
      @states = State.all
      
      render json: @states
    end

    # GET /states/1
    def show
      render json: @state
    end

    # POST /states
    def create
      
     @estado = params[:nameEstado]
     @cidade = params[:nameCidade]
   
     
     @nao = "Erro! Estado ou Cidade não existe no Brasil"
     @sim = "cadastro realizado com sucesso!"
     @res = ""

     @existeEstado = Estado.find_by("lower(nome) = ?", @estado.downcase) 
     if @existeEstado.present?
        @resEs = "cadastro realizado com sucesso!" 
        
     else 
          @resEs = "Erro! Estado ou Cidade não existe no Brasil"
          
     end
      
      @existeCidade  = Cidade.find_by("lower(nome) = ?", @cidade.downcase)
      if @existeCidade.present?
          @resCi = "cadastro realizado com sucesso!"
          
      else 
          @resCi = "Erro! Estado ou Cidade não existe no Brasil"
          
      end

      if @resEs == "cadastro realizado com sucesso!" && @resCi=="cadastro realizado com sucesso!"
            @cad = "nao"
            @pegaSt = State.all
            @pegaCi = City.all

            @pegaSt.each do |es| 
              
              @cids = es.cities

              @cids.each do |ci|
                if ci.name == @cidade
                  @cad ="sim"
                  @resposta = "cadastro ja existe!"
                  
                end  
              end  

            end 
          
          if @cad == "nao"
        
              @resposta = "cadastro realizado com sucesso!"
              @state = State.new(name: @estado)
              @state.save
              @city = @state.cities.new(name: @cidade, state_id: @state.id)
              @city.save

          end   


      else
        @resposta = "Erro! Estado ou Cidade não existe no Brasil"
      end

       render json: @resposta
       
      

    end

    # PATCH/PUT /states/1
    def update
      if @state.update(state_params)
        render json: @state
      else
        render json: @state.errors, status: :unprocessable_entity
      end
    end

    # DELETE /states/1
    def destroy
      @state.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_state
        @state = State.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def state_params
        @test = params.require(:cad).permit(:nameEstado)
      end
  end

end