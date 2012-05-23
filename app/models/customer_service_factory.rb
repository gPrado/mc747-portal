class CustomerServiceFactory < SoapBase
  
  def create(cs)
    response = client.request "Abrir_Chamado", :xmlns => "http://tempuri.org/" do
      http.headers['SOAPAction'] = %("http://tempuri.org/IAtendimentoCliente/Abrir_Chamado")
      tns = 'http://schemas.datacontract.org/2004/07/AtendimentoCliente'

      soap.body = {
        "chamado" => {
          "IdCliente"     => portal_key,
          "TipoChamado"   => cs.tipo, 
          "IdSolicitante" => cs.user_id,
          "Descricao"     => cs.descricao,
          "IdPedido"      => "",
          "IdProduto"     => "",
          :attributes! => {
            "IdCliente"     => { :xmlns => tns },
            "TipoChamado"   => { :xmlns => tns },
            "IdSolicitante" => { :xmlns => tns },
            "Descricao"     => { :xmlns => tns },
            "IdPedido"      => { :xmlns => tns },
            "IdProduto"     => { :xmlns => tns }
          },
          :order! => [ "Descricao", "IdCliente", "IdPedido", "IdProduto", "IdSolicitante", "TipoChamado"]
        }
      }
    end
  end
  
  def find(id)
    response = client.request "Consultar_Chamado", :xmlns => "http://tempuri.org/" do
      http.headers['SOAPAction'] = %("http://tempuri.org/IAtendimentoCliente/Consultar_Chamado")

      soap.body = {
        "idCliente" => portal_key,
        "idChamado" => id
      }
    end
    item = response[:consultar_chamado_response][:consultar_chamado_result]
    build_new_customer_service(item)
  end
  
  def find_all_by_user_id(user_id)
    response = client.request "Consultar_Chamados_Por_Usuario", :xmlns => "http://tempuri.org/" do
      http.headers['SOAPAction'] = %("http://tempuri.org/IAtendimentoCliente/Consultar_Chamados_Por_Usuario")

      soap.body = {
        "idCliente"  => portal_key,
        "idUsuario"  => user_id
      }
    end
    items = response[:consultar_chamados_por_usuario_response][:consultar_chamados_por_usuario_result][:chamado_resumido]
    array = items.is_a?(Array) ? items : [items]
    array.map { |item| build_new_customer_service(item) }
  end
  
  def update(cs)
    response = client.request "Alterar_Chamado", :xmlns => "http://tempuri.org/" do
      http.headers['SOAPAction'] = %("http://tempuri.org/IAtendimentoCliente/Alterar_Chamado")
      tns = 'http://schemas.datacontract.org/2004/07/AtendimentoCliente'

      soap.body = {
        "alteracao" => {
          "IdCliente" => portal_key,
          "IdChamado" => cs.id,
          "Status"    => cs.status,
          "Descricao" => cs.descricao,
          :attributes! => {
            "IdCliente" => { :xmlns => tns },
            "IdChamado" => { :xmlns => tns },
            "Status"    => { :xmlns => tns },
            "Descricao" => { :xmlns => tns }
          },
          :order! => [ "Descricao", "IdChamado", "IdCliente", "Status"]
        }

      }
    end
  end
  
  def get_client
    response = client.request "GetCliente", :xmlns => "http://tempuri.org/" do
      http.headers['SOAPAction'] = %("http://tempuri.org/IAtendimentoCliente/GetCliente")
    end
  end
  
  private
  
  def build_new_customer_service(item)
    alt = item[:alteracoes]
    array = if alt
      alt[:alteracao].is_a?(Array) ? alt[:alteracao] : [alt[:alteracao]]
    else
      []
    end
    alteracoes = array.map{ |a| build_new_customer_service(a)}
    CustomerService.new(:id        => item[:id],
                        :tipo      => item[:tipo_chamado].to_i,
                        :descricao => item[:descricao],
                        :date      => item[:data],
                        :status    => item[:status].to_i,
                        :updates   => alteracoes)
  end
  
  def portal_key
    PortalCustomerServiceInfo.instance.key
  end
  
  class << self
    
    private
    
    def default_wsdl
      "http://mc747atendimento.no-ip.org:2121/AtendimentoCliente.AtendimentoCliente.svc?wsdl"
    end
    
  end
  
end
