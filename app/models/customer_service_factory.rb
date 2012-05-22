class CustomerServiceFactory < SoapBase
  
  def create(cs)
    response = client.request "Abrir_Chamado", :xmlns => "http://tempuri.org/" do
      http.headers['SOAPAction'] = %("http://tempuri.org/IAtendimentoCliente/Abrir_Chamado")

      soap.body = {
        "chamado" => {
          "IdCliente"     => portal_key,
          "TipoChamado"   => cs.tipo,
          "IdSolicitante" => cs.user_id,
          "Descricao"     => cs.descricao
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
  end
  
  def find_all_by_user_id(user_id)
    response = client.request "Consultar_Chamados_Por_Usuario", :xmlns => "http://tempuri.org/" do
      http.headers['SOAPAction'] = %("http://tempuri.org/IAtendimentoCliente/Consultar_Chamados_Por_Usuario")

      soap.body = {
        "idCliente"  => portal_key,
        "idUsuario"  => user_id
      }
    end
  end
  
  def update(cs)
    response = client.request "Alterar_Chamado", :xmlns => "http://tempuri.org/" do
      http.headers['SOAPAction'] = %("http://tempuri.org/IAtendimentoCliente/Alterar_Chamado")

      soap.body = {
        "alteracao" => {
          "IdCliente" => portal_key,
          "IdChamado" => cs.id,
          "Status"    => cs.status,
          "Descricao" => cs.descricao
        }
      }
    end
  end
  
  private
  
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
