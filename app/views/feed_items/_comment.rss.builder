c ||= comment
c ||= feed_item.item

xml = xml_instance unless xml_instance.nil?
xml.item do
  if !feed_item.item.blank?
    xml.title commentable_text(c, false)
    xml.link profile_feed_item_url(@profile, c)
    xml.guid profile_feed_item_url(@profile, c)
    xml.description c.comment
    xml.author "#{c.profile.email} (#{c.profile.full_name})"
    xml.pubDate c.updated_at
  end
end