class ApiUrls{
  static const String baseUrl = String.fromEnvironment('API_URL', defaultValue: 'https://test.satta.biz/api/v1');
  static const String login = "$baseUrl/login.json";
  static const String logout = "$baseUrl/logout.json";
  static String proposal(String supplierId) {
    return "$baseUrl/proposals_by_state_sp.json?proposal_state='pending','replied','proposal_stvs','last_offer'&supplier_id=$supplierId";}
  static String order (String supplierId){
    return "$baseUrl/order_list_sp.json?state='order_approved','order_confirmed','order_prepared','order_on_the_way','order_delivered'&supplier_id=$supplierId";
  }
  static String shipment (String supplierId){
    return "$baseUrl/shipment_list_sp.json?state='order_prepared','order_on_the_way'&supplier_id=$supplierId";
  }
  static String invoices(String supplierId){
    return "$baseUrl/buyer_invoice_list_sp.json?state='invoice_discounted','invoice_goods_delivered','invoice_collecting','invoice_approved_dbs', 'invoice_approved'&supplier_id=$supplierId";
  }
  static String getMessage (String id){
    return "$baseUrl/list_messages.json?$id";
  }
  static const String createMessage = "$baseUrl/post_message.json";
  static const String forgotPassword = "$baseUrl/forgot_password.json";
  static const String favoriteList = "$baseUrl/list_favorite_list.json";
  static const String userInfo = "$baseUrl/current_user_info.json";
  static const String createProposal = "$baseUrl/demand_proposal_sp.json";
  static const String createOrder = "$baseUrl/create_order_by_proposal_sp.json";
  static const String shipmentDelivered = "$baseUrl/shipment_delivered.json";
  static const String invoiceApproved = "$baseUrl/invoice_approved.json";
  static const String webContent = "$baseUrl/seller_point_web_content.json";
}