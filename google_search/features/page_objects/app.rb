class App
  page_class = {:google_home => Google
  }

  page_class.keys.each do |method|
    define_method method do
      page_class[method].send("new".to_sym)
    end
  end


end