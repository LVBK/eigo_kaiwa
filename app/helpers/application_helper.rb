module ApplicationHelper
    def full_title(page_title = '')
       base_title = "英語会話 | Eigo Kaiwa" 
       if page_title.empty?
           base_title
       else
           "#{page_title} | #{base_title}"
       end
    end
end
