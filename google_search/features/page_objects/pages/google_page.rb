class Google<SitePrism::Page
  set_url "http://www.google.com"
  element :search_txt,'#gbqfq'
  element :search_btn,'#gbqfb'
  elements :ads,'#tads cite'
end