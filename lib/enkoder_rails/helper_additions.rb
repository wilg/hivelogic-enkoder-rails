module EnkoderRails
  module HelperAdditions

    require "active_support/core_ext/string/output_safety"   

    def enkode( html, max_length=1024 )

      rnd = 10 + (rand*90).to_i

      kodes = [
        {
          'rb' => lambda do |s|
            s.reverse
          end,
          'js' => ";kode=kode.split('').reverse().join('')"
        },
        {
          'rb' => lambda do |s|
            result = ''
            s.each_byte { |b|
              b += 3
              b-=128 if b>127
              result += b.chr
            }
            result
          end,
          'js' => (
             ";x='';for(i=0;i<kode.length;i++){c=kode.charCodeAt(i)-3;" +
             "if(c<0)c+=128;x+=String.fromCharCode(c)}kode=x"
           )
        },
        {
          'rb' => lambda do |s|
            for i in (0..s.length/2-1)
              s[i*2],s[i*2+1] = s[i*2+1],s[i*2]
            end
            s
          end,
          'js' => (
             ";x='';for(i=0;i<(kode.length-1);i+=2){" +
             "x+=kode.charAt(i+1)+kode.charAt(i)}" +
             "kode=x+(i<kode.length?kode.charAt(kode.length-1):'');"
           )
        }
      ]

      kode = "document.write("+ js_dbl_quote(html) +");"

      max_length = kode.length+1 unless max_length>kode.length

      result = ''

      while kode.length < max_length
        idx = (rand*kodes.length).to_i
        kode = kodes[idx]['rb'].call(kode)
        kode = "kode=" + js_dbl_quote(kode) + kodes[idx]['js']
        js = "var kode=\n"+js_wrap_quote(js_dbl_quote(kode),79)
        js = js+"\n;var i,c,x;while(eval(kode));"
        js = "function hivelogic_enkoder(){"+js+"}hivelogic_enkoder();"
        js = '<script type="text/javascript">'+"\n/* <![CDATA[ */\n"+js
        js = js+"\n/* ]]> */\n</script>"
        result = js unless result.length>max_length
      end

      result.html_safe

    end
    
    def enkode_mail( email, link_text, title_text=nil, subject=nil )
      str = String.new
      str << '<a href="mailto:' + email
      str << '?subject=' + subject unless subject.nil?
      str << '" title="'
      str << title_text unless title_text.nil?
      str << '">' + link_text + '</a>'
      enkode(str)
    end

    private

      def js_dbl_quote( str )
        str.inspect
      end

      def js_wrap_quote( str, max_line_length )
        max_line_length -= 3
        inQ = false
        esc = 0
        lineLen = 0
        result = ''
        chunk = ''
        while str.length > 0
          if str =~ /^\\[0-7]{3}/
            chunk = str[0..3]
            str[0..3] = ''
          elsif str =~ /^\\./
            chunk = str[0..1]
            str[0..1] = ''
          else
            chunk = str[0..0]
            str[0..0] = ''
          end
          if lineLen+chunk.length >= max_line_length
            result += '"+'+"\n"+'"'
            lineLen = 1
          end
          lineLen += chunk.length
          result += chunk;
        end
        result
      end

  end
end
