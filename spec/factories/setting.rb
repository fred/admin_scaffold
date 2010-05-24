Factory.define :site_meta_description, :class => Setting do |u|
  u.var "site_meta_description"
  u.value "site_meta_description"
end
Factory.define :site_meta_keywords, :class => Setting do |u|
  u.var "site_meta_keywords"
  u.value "site_meta_keywords"
end
Factory.define :site_meta_title, :class => Setting do |u|
  u.var "site_meta_title"
  u.value "site_meta_title"
end
Factory.define :site_email_alert, :class => Setting do |u|
  u.var "site_email_alert"
  u.value "site_email_alert"
end
Factory.define :site_email_alert_subject, :class => Setting do |u|
  u.var "site_email_alert_subject"
  u.value "site_email_alert_subject"
end
Factory.define :site_email, :class => Setting do |u|
  u.var "site_email"
  u.value "site_email"
end
Factory.define :site_title, :class => Setting do |u|
  u.var "site_title"
  u.value "site_title"
end
Factory.define :site_sub_title, :class => Setting do |u|
  u.var "site_sub_title"
  u.value "site_sub_title"
end
Factory.define :ga_key, :class => Setting do |u|
  u.var "ga_key"
  u.value "ga_key"
end
Factory.define :display_per_page, :class => Setting do |u|
  u.var "display_per_page"
  u.value 25
end
