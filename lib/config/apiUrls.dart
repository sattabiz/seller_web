class ApiUrls{
  static const String baseUrl = String.fromEnvironment('API_URL', defaultValue: 'http://localhost');
  
  
  static const String login = "$baseUrl/login.json";
  static const String logout = "$baseUrl/logout.json";
  static const String proposal = "$baseUrl/proposals_by_state.json?proposal_state='pending'";
  static const String order = "$baseUrl/order_list.json?state='order_approved','order_confirmed','order_prepared','order_on_the_way','order_delivered'";
  static const String shipment = "$baseUrl/shipment_list.json?state='order_on_the_way','delivered'";
  static const String invoices = '$baseUrl/buyer_invoice_list.json?state="invoice_discounted","invoice_paid","invoice_pending","invoice_approved_dbs"&saved_to_erp=false';
  static const String favoriteList = "$baseUrl/list_favorite_list.json";
  static const String userInfo = "$baseUrl/current_user_info.json";
  static const String createProposal = "$baseUrl/demand_proposal_sp.json";
  static const String webContent = "$baseUrl/seller_point_web_content.json";
}