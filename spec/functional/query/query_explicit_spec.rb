describe Poisol::Stub, "#query_explicit" do

  it "partial" do
    BookExplicit.new.for_author('bha').build()
    response = RestClient.get "http://localhost:3030/book_explicit",{:params => {:author=>'bha'}}
    expect(response.body).to eq({"title"=>"independance", "category"=>{"age_group"=>"10", "genre"=>"action", "publisher"=>{"name"=>"summa", "place"=>"erode"}}}.to_json)
  end

  it "full dymamic" do
    Book.new.for_author('asd').for_name('don').build()
    response = RestClient.get "http://localhost:3030/book",{:params => {:author=>'asd',:name=>'don'}}
    expect(response.body).to eq({"title"=>"independance", "category"=>{"age_group"=>"10", "genre"=>"action", "publisher"=>{"name"=>"summa", "place"=>"erode"}}}.to_json)
  end

  it "full dymamic hash params" do
    Book.new.for(:author => 'asd',:name =>'don').build
    response = RestClient.get "http://localhost:3030/book",{:params => {:author=>'asd',:name=>'don'}}
    expect(response.body).to eq({"title"=>"independance", "category"=>{"age_group"=>"10", "genre"=>"action", "publisher"=>{"name"=>"summa", "place"=>"erode"}}}.to_json)
  end

  it "add custom query params" do
    Book.new.for_custom(color: 'red').for_author('bha').for_name('don').build()
    response = RestClient.get "http://localhost:3030/book",{:params => {:author => 'bha',:name=> 'don',:color=>'red'}}
    expect(response.body).to eq({"title"=>"independance", "category"=>{"age_group"=>"10", "genre"=>"action", "publisher"=>{"name"=>"summa", "place"=>"erode"}}}.to_json)
  end

  it "removes default query params" do
    Book.new.without(:author).build()
    response = RestClient.get "http://localhost:3030/book",{:params => {:name=> 'doni'}}
    expect(response.body).to eq({"title"=>"independance", "category"=>{"age_group"=>"10", "genre"=>"action", "publisher"=>{"name"=>"summa", "place"=>"erode"}}}.to_json)
  end
end
