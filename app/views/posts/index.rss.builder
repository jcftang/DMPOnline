xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title       t('dmp.rss_title') 
    xml.description t('dmp.rss_description')
    xml.language    I18n.locale.to_s
    xml.copyright   current_organisation.full_name
    xml.generator   "DCC DMPOnline Tool: dcc.ac.uk/dmponline"
    xml.link        posts_path
    xml.ttl         360
    @posts.each do |post|
      xml.item do
        xml.title       post.title
        xml.author      post.author.try(:email) 
        xml.description h(sanitize post.body)
        xml.pubDate     post.created_at.to_s(:rfc822)
        xml.link        post_path(post)
        xml.guid        post
      end
    end
  end
end