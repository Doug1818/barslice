module ApplicationHelper
	
	# Returns the full title on a per-page basis
	def full_title(page_title)
		base_title = "BarSlice"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	# Dynamically adds fields for nested forms
	def link_to_add_fields(name, f, association)
	    new_object = f.object.send(association).klass.new
	    id = new_object.object_id
	    fields = f.fields_for(association, new_object, child_index: id) do |builder|
	      render(association.to_s.singularize + "_fields", f: builder)
	    end
    	link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  	end

  	# Adds http:// ahead of websites
  	def url_with_protocol(url)
    	/^http/.match(url) ? url : "http://#{url}"
  	end
end
