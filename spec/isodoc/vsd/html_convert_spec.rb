require "spec_helper"

logoloc = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "..", "lib", "isodoc", "vsd", "html"))

RSpec.describe IsoDoc::Acme do

  it "processes default metadata" do
    csdc = IsoDoc::Acme::HtmlConvert.new({})
    input = <<~"INPUT"
<vsd-standard xmlns="https://open.ribose.com/standards/vsd">
<bibdata type="standard">
  <title language="en" format="plain">Main Title</title>
  <docidentifier>1000</docidentifier>
  <contributor>
    <role type="author"/>
    <organization>
      <name>#{Metanorma::Acme.configuration.organization_name_long}</name>
    </organization>
  </contributor>
  <contributor>
    <role type="publisher"/>
    <organization>
      <name>#{Metanorma::Acme.configuration.organization_name_long}</name>
    </organization>
  </contributor>
  <language>en</language>
  <script>Latn</script>
  <status><stage>working-draft</stage></status>
  <copyright>
    <from>2001</from>
    <owner>
      <organization>
        <name>#{Metanorma::Acme.configuration.organization_name_long}</name>
      </organization>
    </owner>
  </copyright>
  <editorialgroup>
    <committee type="A">TC</committee>
  </editorialgroup>
  <security>Client Confidential</security>
</bibdata><version>
  <edition>2</edition>
  <revision-date>2000-01-01</revision-date>
  <draft>3.4</draft>
</version>
<sections/>
</vsd-standard>
    INPUT

    output = <<~"OUTPUT"
        {:accesseddate=>"XXX", :agency=>"Vita Green", :authors=>[], :authors_affiliations=>{}, :circulateddate=>"XXX", :confirmeddate=>"XXX", :copieddate=>"XXX", :createddate=>"XXX", :docnumber=>"1000(wd)", :doctitle=>"Main Title", :docyear=>"2001", :draft=>"3.4", :draftinfo=>" (draft 3.4, 2000-01-01)", :edition=>nil, :implementeddate=>"XXX", :issueddate=>"XXX", :logo=>"#{File.join(logoloc, "logo.png")}", :obsoleteddate=>"XXX", :publisheddate=>"XXX", :receiveddate=>"XXX", :revdate=>"2000-01-01", :revdate_monthyear=>"January 2000", :stage=>"Working Draft", :transmitteddate=>"XXX", :unchangeddate=>"XXX", :unpublished=>true, :updateddate=>"XXX"}
    OUTPUT

    docxml, filename, dir = csdc.convert_init(input, "test", true)
    expect(htmlencode(Hash[csdc.info(docxml, nil).sort].to_s)).to be_equivalent_to output
  end

  it "abbreviates committee-draft" do
    input = <<~"INPUT"
<vsd-standard xmlns="https://open.ribose.com/standards/vsd">
<bibdata type="standard">
  <status><stage>committee-draft</stage></status>
</bibdata><version>
  <edition>2</edition>
  <revision-date>2000-01-01</revision-date>
  <draft>3.4</draft>
</version>
<sections/>
</vsd-standard>
    INPUT

    output = <<~"OUTPUT"
      {:accesseddate=>"XXX", :agency=>"", :authors=>[], :authors_affiliations=>{}, :circulateddate=>"XXX", :confirmeddate=>"XXX", :copieddate=>"XXX", :createddate=>"XXX", :docnumber=>"(cd)", :doctitle=>nil, :docyear=>nil, :draft=>"3.4", :draftinfo=>" (draft 3.4, 2000-01-01)", :edition=>nil, :implementeddate=>"XXX", :issueddate=>"XXX", :logo=>"#{File.join(logoloc, "logo.png")}", :obsoleteddate=>"XXX", :publisheddate=>"XXX", :receiveddate=>"XXX", :revdate=>"2000-01-01", :revdate_monthyear=>"January 2000", :stage=>"Committee Draft", :transmitteddate=>"XXX", :unchangeddate=>"XXX", :unpublished=>true, :updateddate=>"XXX"}
    OUTPUT

    csdc = IsoDoc::Acme::HtmlConvert.new({})
    docxml, filename, dir = csdc.convert_init(input, "test", true)
    expect(htmlencode(Hash[csdc.info(docxml, nil).sort].to_s)).to be_equivalent_to output
  end

  it "abbreviates draft-standard" do
    input = <<~"INPUT"
<vsd-standard xmlns="https://open.ribose.com/standards/vsd">
<bibdata type="standard">
  <status><stage>draft-standard</stage></status>
</bibdata><version>
  <edition>2</edition>
  <revision-date>2000-01-01</revision-date>
  <draft>3.4</draft>
</version>
<sections/>
</vsd-standard>
    INPUT

    output = <<~"OUTPUT"
      {:accesseddate=>"XXX", :agency=>"", :authors=>[], :authors_affiliations=>{}, :circulateddate=>"XXX", :confirmeddate=>"XXX", :copieddate=>"XXX", :createddate=>"XXX", :docnumber=>"(d)", :doctitle=>nil, :docyear=>nil, :draft=>"3.4", :draftinfo=>" (draft 3.4, 2000-01-01)", :edition=>nil, :implementeddate=>"XXX", :issueddate=>"XXX", :logo=>"#{File.join(logoloc, "logo.png")}", :obsoleteddate=>"XXX", :publisheddate=>"XXX", :receiveddate=>"XXX", :revdate=>"2000-01-01", :revdate_monthyear=>"January 2000", :stage=>"Draft Standard", :transmitteddate=>"XXX", :unchangeddate=>"XXX", :unpublished=>true, :updateddate=>"XXX"}
    OUTPUT

    csdc = IsoDoc::Acme::HtmlConvert.new({})
    docxml, filename, dir = csdc.convert_init(input, "test", true)
    expect(htmlencode(Hash[csdc.info(docxml, nil).sort].to_s)).to be_equivalent_to output
  end

  it "ignores unrecognised status" do
    input = <<~"INPUT"
<vsd-standard xmlns="https://open.ribose.com/standards/vsd">
<bibdata type="standard">
  <status><stage>standard</stage></status>
</bibdata><version>
  <edition>2</edition>
  <revision-date>2000-01-01</revision-date>
  <draft>3.4</draft>
</version>
<sections/>
</vsd-standard>
    INPUT

    output = <<~"OUTPUT"
      {:accesseddate=>"XXX", :agency=>"", :authors=>[], :authors_affiliations=>{}, :circulateddate=>"XXX", :confirmeddate=>"XXX", :copieddate=>"XXX", :createddate=>"XXX", :docnumber=>nil, :doctitle=>nil, :docyear=>nil, :draft=>"3.4", :draftinfo=>" (draft 3.4, 2000-01-01)", :edition=>nil, :implementeddate=>"XXX", :issueddate=>"XXX", :logo=>"#{File.join(logoloc, "logo.png")}", :obsoleteddate=>"XXX", :publisheddate=>"XXX", :receiveddate=>"XXX", :revdate=>"2000-01-01", :revdate_monthyear=>"January 2000", :stage=>"Standard", :transmitteddate=>"XXX", :unchangeddate=>"XXX", :unpublished=>true, :updateddate=>"XXX"}
    OUTPUT

    csdc = IsoDoc::Acme::HtmlConvert.new({})
    docxml, filename, dir = csdc.convert_init(input, "test", true)
    expect(htmlencode(Hash[csdc.info(docxml, nil).sort].to_s)).to be_equivalent_to output
  end

  it "processes pre" do
    input = <<~"INPUT"
<vsd-standard xmlns="https://open.ribose.com/standards/vsd">
<preface><foreword>
<pre>ABC</pre>
</foreword></preface>
</vsd-standard>
    INPUT

    output = xmlpp(<<~"OUTPUT")
    #{HTML_HDR}
             <br/>
             <div>
               <h1 class="ForewordTitle">Foreword</h1>
               <pre>ABC</pre>
             </div>
             <p class="zzSTDTitle1"/>
           </div>
         </body>
    OUTPUT

    expect(xmlpp(
      IsoDoc::Acme::HtmlConvert.new({}).
      convert("test", input, true).
      gsub(%r{^.*<body}m, "<body").
      gsub(%r{</body>.*}m, "</body>")
    )).to be_equivalent_to output
  end

  it "processes keyword" do
    input = <<~"INPUT"
<vsd-standard xmlns="https://open.ribose.com/standards/vsd">
<preface><foreword>
<keyword>ABC</keyword>
</foreword></preface>
</vsd-standard>
    INPUT

    output = xmlpp(<<~"OUTPUT")
        #{HTML_HDR}
             <br/>
             <div>
               <h1 class="ForewordTitle">Foreword</h1>
               <span class="keyword">ABC</span>
             </div>
             <p class="zzSTDTitle1"/>
           </div>
         </body>
    OUTPUT
    stripped_html = xmlpp(IsoDoc::Acme::HtmlConvert.new({})
                          .convert('test', input, true)
                          .gsub(%r{^.*<body}m, '<body')
                          .gsub(%r{</body>.*}m, '</body>'))
    expect(stripped_html).to(be_equivalent_to(output))
  end

  it "processes simple terms & definitions" do
    input = <<~"INPUT"
     <vsd-standard xmlns="http://riboseinc.com/isoxml">
       <sections>
       <terms id="H" obligation="normative"><title>Terms, Definitions, Symbols and Abbreviated Terms</title>
         <term id="J">
         <preferred>Term2</preferred>
       </term>
        </terms>
        </sections>
        </vsd-standard>
    INPUT

    output = xmlpp(<<~"OUTPUT")
        #{HTML_HDR}
             <p class="zzSTDTitle1"/>
             <div id="H"><h1>1.&#160; Terms and definitions</h1>
       <p class="TermNum" id="J">1.1.</p>
         <p class="Terms" style="text-align:left;">Term2</p>
       </div>
           </div>
         </body>
    OUTPUT
    stripped_html = xmlpp(IsoDoc::Acme::HtmlConvert.new({})
                          .convert('test', input, true)
                          .gsub(%r{^.*<body}m, '<body')
                          .gsub(%r{</body>.*}m, '</body>'))
    expect(stripped_html).to(be_equivalent_to(output))
  end

  it "processes section names" do
    input = <<~"INPUT"
    <vsd-standard xmlns="http://riboseinc.com/isoxml">
      <preface>
      <foreword obligation="informative">
         <title>Foreword</title>
         <p id="A">This is a preamble</p>
       </foreword>
        <introduction id="B" obligation="informative"><title>Introduction</title><clause id="C" inline-header="false" obligation="informative">
         <title>Introduction Subsection</title>
       </clause>
       </introduction></preface><sections>
       <clause id="D" obligation="normative">
         <title>Scope</title>
         <p id="E">Text</p>
       </clause>

       <clause id="H" obligation="normative"><title>Terms, Definitions, Symbols and Abbreviated Terms</title><terms id="I" obligation="normative">
         <title>Normal Terms</title>
         <term id="J">
         <preferred>Term2</preferred>
       </term>
       </terms>
       <definitions id="K">
         <dl>
         <dt>Symbol</dt>
         <dd>Definition</dd>
         </dl>
       </definitions>
       </clause>
       <definitions id="L">
         <dl>
         <dt>Symbol</dt>
         <dd>Definition</dd>
         </dl>
       </definitions>
       <clause id="M" inline-header="false" obligation="normative"><title>Clause 4</title><clause id="N" inline-header="false" obligation="normative">
         <title>Introduction</title>
       </clause>
       <clause id="O" inline-header="false" obligation="normative">
         <title>Clause 4.2</title>
       </clause></clause>

       </sections><annex id="P" inline-header="false" obligation="normative">
         <title>Annex</title>
         <clause id="Q" inline-header="false" obligation="normative">
         <title>Annex A.1</title>
         <clause id="Q1" inline-header="false" obligation="normative">
         <title>Annex A.1a</title>
         </clause>
       </clause>
       </annex><bibliography><references id="R" obligation="informative">
         <title>Normative References</title>
       </references><clause id="S" obligation="informative">
         <title>Bibliography</title>
         <references id="T" obligation="informative">
         <title>Bibliography Subsection</title>
       </references>
       </clause>
       </bibliography>
       </vsd-standard>
    INPUT

    output = xmlpp(<<~"OUTPUT")
        #{HTML_HDR}
             <br/>
             <div>
               <h1 class="ForewordTitle">Foreword</h1>
               <p id="A">This is a preamble</p>
             </div>
             <br/>
             <div class="Section3" id="B">
               <h1 class="IntroTitle">Introduction</h1>
               <div id="C">
          <h2>Introduction Subsection</h2>
        </div>
             </div>
             <p class="zzSTDTitle1"/>
             <div id="D">
               <h1>1.&#160; Scope</h1>
               <p id="E">Text</p>
             </div>
             <div>
               <h1>2.&#160; Normative references</h1>
             </div>
             <div id="H"><h1>3.&#160; Terms, definitions, symbols and abbreviated terms</h1>
       <div id="I">
          <h2>3.1.&#160; Normal Terms</h2>
          <p class="TermNum" id="J">3.1.1.</p>
          <p class="Terms" style="text-align:left;">Term2</p>

        </div><div id="K"><h2>3.2.&#160; Symbols and abbreviated terms</h2>
          <dl><dt><p>Symbol</p></dt><dd>Definition</dd></dl>
        </div></div>
             <div id="L" class="Symbols">
               <h1>4.&#160; Symbols and abbreviated terms</h1>
               <dl>
                 <dt>
                   <p>Symbol</p>
                 </dt>
                 <dd>Definition</dd>
               </dl>
             </div>
             <div id="M">
               <h1>5.&#160; Clause 4</h1>
               <div id="N">
          <h2>5.1.&#160; Introduction</h2>
        </div>
               <div id="O">
          <h2>5.2.&#160; Clause 4.2</h2>
        </div>
             </div>
             <br/>
             <div id="P" class="Section3">
               <h1 class="Annex"><b>Annex A</b><br/>(normative)<br/><b>Annex</b></h1>
               <div id="Q">
          <h2>A.1.&#160; Annex A.1</h2>
          <div id="Q1">
          <h3>A.1.1.&#160; Annex A.1a</h3>
          </div>
        </div>
             </div>
             <br/>
             <div>
               <h1 class="Section3">Bibliography</h1>
               <div>
                 <h2 class="Section3">Bibliography Subsection</h2>
               </div>
             </div>
           </div>
         </body>
    OUTPUT
    stripped_html = xmlpp(IsoDoc::Acme::HtmlConvert
                          .new({})
                          .convert('test', input, true)
                          .gsub(%r{^.*<body}m, '<body')
                          .gsub(%r{</body>.*}m, '</body>'))
    expect(stripped_html).to(be_equivalent_to(output))
  end

  it "injects JS into blank html" do
    system "rm -f test.html"
    input = <<~"INPUT"
      = Document title
      Author
      :docfile: test.adoc
      :novalid:
    INPUT

    output = xmlpp(<<~"OUTPUT")
    #{BLANK_HDR}
<sections/>
</vsd-standard>
    OUTPUT

    expect(xmlpp(Asciidoctor.convert(input, backend: :vsd, header_footer: true))).to be_equivalent_to output
    html = File.read("test.html", encoding: "utf-8")
    expect(html).to match(%r{jquery\.min\.js})
    expect(html).to match(%r{Overpass})
  end

end

