require "spec_helper"

logoloc = File.expand_path(File.join(File.dirname(__FILE__), "..", "..", "lib", "isodoc", "vg", "html"))

RSpec.describe IsoDoc::VG do

  it "processes default metadata" do
    csdc = IsoDoc::VG::HtmlConvert.new({})
    input = <<~"INPUT"
<vsd-standard xmlns="https://open.ribose.com/standards/vsd">
<bibdata type="standard">
  <title language="en" format="plain">Main Title</title>
  <docidentifier>1000</docidentifier>
  <contributor>
    <role type="author"/>
    <organization>
      <name>#{Metanorma::VG.configuration.organization_name_long}</name>
    </organization>
  </contributor>
  <contributor>
    <role type="publisher"/>
    <organization>
      <name>#{Metanorma::VG.configuration.organization_name_long}</name>
    </organization>
  </contributor>
  <language>en</language>
  <script>Latn</script>
  <status><stage>working-draft</stage></status>
  <copyright>
    <from>2001</from>
    <owner>
      <organization>
        <name>#{Metanorma::VG.configuration.organization_name_long}</name>
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
{:accesseddate=>"XXX",
:agency=>"Vita Green",
:authors=>[],
:authors_affiliations=>{},
:circulateddate=>"XXX",
:confirmeddate=>"XXX",
:copieddate=>"XXX",
:createddate=>"XXX",
:docnumber=>"1000",
:docnumeric=>nil,
:doctitle=>"Main Title",
:docyear=>"2001",
:draft=>"3.4",
:draftinfo=>" (draft 3.4, 2000-01-01)",
:edition=>nil,
:implementeddate=>"XXX",
:issueddate=>"XXX",
:keywords=>[],
:logo=>"#{File.join(logoloc, "logo.png")}",
:obsoleteddate=>"XXX",
:publisheddate=>"XXX",
:publisher=>"Vita Green",
:receiveddate=>"XXX",
:revdate=>"2000-01-01",
:revdate_monthyear=>"January 2000",
:stage=>"Working Draft",
:stageabbr=>"WD",
:transmitteddate=>"XXX",
:unchangeddate=>"XXX",
:unpublished=>true,
:updateddate=>"XXX",
:vote_endeddate=>"XXX",
:vote_starteddate=>"XXX"}
    OUTPUT

    docxml, filename, dir = csdc.convert_init(input, "test", true)
    expect(htmlencode(Hash[csdc.info(docxml, nil).sort].to_s.gsub(/, :/, ",\n:"))).to be_equivalent_to output
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
{:accesseddate=>"XXX",
:agency=>"",
:authors=>[],
:authors_affiliations=>{},
:circulateddate=>"XXX",
:confirmeddate=>"XXX",
:copieddate=>"XXX",
:createddate=>"XXX",
:docnumber=>nil,
:docnumeric=>nil,
:doctitle=>nil,
:docyear=>nil,
:draft=>"3.4",
:draftinfo=>" (draft 3.4, 2000-01-01)",
:edition=>nil,
:implementeddate=>"XXX",
:issueddate=>"XXX",
:keywords=>[],
:logo=>"#{File.join(logoloc, "logo.png")}",
:obsoleteddate=>"XXX",
:publisheddate=>"XXX",
:publisher=>"",
:receiveddate=>"XXX",
:revdate=>"2000-01-01",
:revdate_monthyear=>"January 2000",
:stage=>"Committee Draft",
:stageabbr=>"CD",
:transmitteddate=>"XXX",
:unchangeddate=>"XXX",
:unpublished=>true,
:updateddate=>"XXX",
:vote_endeddate=>"XXX",
:vote_starteddate=>"XXX"}
    OUTPUT

    csdc = IsoDoc::VG::HtmlConvert.new({})
    docxml, filename, dir = csdc.convert_init(input, "test", true)
    expect(htmlencode(Hash[csdc.info(docxml, nil).sort].to_s.gsub(/, :/, ",\n:"))).to be_equivalent_to output
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
{:accesseddate=>"XXX",
:agency=>"",
:authors=>[],
:authors_affiliations=>{},
:circulateddate=>"XXX",
:confirmeddate=>"XXX",
:copieddate=>"XXX",
:createddate=>"XXX",
:docnumber=>nil,
:docnumeric=>nil,
:doctitle=>nil,
:docyear=>nil,
:draft=>"3.4",
:draftinfo=>" (draft 3.4, 2000-01-01)",
:edition=>nil,
:implementeddate=>"XXX",
:issueddate=>"XXX",
:keywords=>[],
:logo=>"#{File.join(logoloc, "logo.png")}",
:obsoleteddate=>"XXX",
:publisheddate=>"XXX",
:publisher=>"",
:receiveddate=>"XXX",
:revdate=>"2000-01-01",
:revdate_monthyear=>"January 2000",
:stage=>"Draft Standard",
:stageabbr=>"DS",
:transmitteddate=>"XXX",
:unchangeddate=>"XXX",
:unpublished=>true,
:updateddate=>"XXX",
:vote_endeddate=>"XXX",
:vote_starteddate=>"XXX"}
    OUTPUT

    csdc = IsoDoc::VG::HtmlConvert.new({})
    docxml, filename, dir = csdc.convert_init(input, "test", true)
    expect(htmlencode(Hash[csdc.info(docxml, nil).sort].to_s.gsub(/, :/, ",\n:"))).to be_equivalent_to output
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
{:accesseddate=>"XXX",
:agency=>"",
:authors=>[],
:authors_affiliations=>{},
:circulateddate=>"XXX",
:confirmeddate=>"XXX",
:copieddate=>"XXX",
:createddate=>"XXX",
:docnumber=>nil,
:docnumeric=>nil,
:doctitle=>nil,
:docyear=>nil,
:draft=>"3.4",
:draftinfo=>" (draft 3.4, 2000-01-01)",
:edition=>nil,
:implementeddate=>"XXX",
:issueddate=>"XXX",
:keywords=>[],
:logo=>"#{File.join(logoloc, "logo.png")}",
:obsoleteddate=>"XXX",
:publisheddate=>"XXX",
:publisher=>"",
:receiveddate=>"XXX",
:revdate=>"2000-01-01",
:revdate_monthyear=>"January 2000",
:stage=>"Standard",
:stageabbr=>"S",
:transmitteddate=>"XXX",
:unchangeddate=>"XXX",
:unpublished=>true,
:updateddate=>"XXX",
:vote_endeddate=>"XXX",
:vote_starteddate=>"XXX"}
    OUTPUT

    csdc = IsoDoc::VG::HtmlConvert.new({})
    docxml, filename, dir = csdc.convert_init(input, "test", true)
    expect(htmlencode(Hash[csdc.info(docxml, nil).sort].to_s.gsub(/, :/, ",\n:"))).to be_equivalent_to output
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
      IsoDoc::VG::HtmlConvert.new({}).
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
    stripped_html = xmlpp(IsoDoc::VG::HtmlConvert.new({})
                          .convert('test', input, true)
                          .gsub(%r{^.*<body}m, '<body')
                          .gsub(%r{</body>.*}m, '</body>'))
    expect(stripped_html).to(be_equivalent_to(output))
  end

  it "processes simple terms & definitions" do
    input = <<~"INPUT"
     <vsd-standard xmlns="http://riboseinc.com/isoxml">
       <sections>
       <terms id="H" obligation="normative"><title>1.<tab/>Terms, Definitions, Symbols and Abbreviated Terms</title>
         <term id="J">
         <name>1.1.</name>
         <preferred>Term2</preferred>
       </term>
        </terms>
        </sections>
        </vsd-standard>
    INPUT

    output = xmlpp(<<~"OUTPUT")
        #{HTML_HDR}
             <p class="zzSTDTitle1"/>
             <div id="H"><h1>1.&#160; Terms, Definitions, Symbols and Abbreviated Terms</h1>
       <p class="TermNum" id="J">1.1.</p>
         <p class="Terms" style="text-align:left;">Term2</p>
       </div>
           </div>
         </body>
    OUTPUT
    stripped_html = xmlpp(IsoDoc::VG::HtmlConvert.new({})
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
       </annex><bibliography><references id="R" obligation="informative" normative="true">
         <title>Normative References</title>
       </references><clause id="S" obligation="informative">
         <title>Bibliography</title>
         <references id="T" obligation="informative" normative="false">
         <title>Bibliography Subsection</title>
       </references>
       </clause>
       </bibliography>
       </vsd-standard>
    INPUT

    output = xmlpp(<<~"OUTPUT")
    <vsd-standard xmlns='http://riboseinc.com/isoxml' type="presentation">
         <preface>
           <foreword obligation='informative'>
             <title>Foreword</title>
             <p id='A'>This is a preamble</p>
           </foreword>
           <introduction id='B' obligation='informative'>
             <title>Introduction</title>
             <clause id='C' inline-header='false' obligation='informative'>
               <title depth='2'>Introduction Subsection</title>
             </clause>
           </introduction>
         </preface>
         <sections>
           <clause id='D' obligation='normative'>
             <title depth='1'>
               4.
               <tab/>
               Scope
             </title>
             <p id='E'>Text</p>
           </clause>
           <clause id='H' obligation='normative'>
             <title depth='1'>
               2.
               <tab/>
               Terms, Definitions, Symbols and Abbreviated Terms
             </title>
             <terms id='I' obligation='normative'>
               <title depth='2'>
                 2.1.
                 <tab/>
                 Normal Terms
               </title>
               <term id='J'>
                 <name>2.1.1.</name>
                 <preferred>Term2</preferred>
               </term>
             </terms>
             <definitions id='K'>
               <title>2.2.</title>
               <dl>
                 <dt>Symbol</dt>
                 <dd>Definition</dd>
               </dl>
             </definitions>
           </clause>
           <definitions id='L'>
             <title>3.</title>
             <dl>
               <dt>Symbol</dt>
               <dd>Definition</dd>
             </dl>
           </definitions>
           <clause id='M' inline-header='false' obligation='normative'>
             <title depth='1'>
               5.
               <tab/>
               Clause 4
             </title>
             <clause id='N' inline-header='false' obligation='normative'>
               <title depth='2'>
                 5.1.
                 <tab/>
                 Introduction
               </title>
             </clause>
             <clause id='O' inline-header='false' obligation='normative'>
               <title depth='2'>
                 5.2.
                 <tab/>
                 Clause 4.2
               </title>
             </clause>
           </clause>
         </sections>
         <annex id='P' inline-header='false' obligation='normative'>
           <title>
             <strong>Annex A</strong>
             <br/>
             (normative)
             <br/>
             <strong>Annex</strong>
           </title>
           <clause id='Q' inline-header='false' obligation='normative'>
             <title depth='2'>
               A.1.
               <tab/>
               Annex A.1
             </title>
             <clause id='Q1' inline-header='false' obligation='normative'>
               <title depth='3'>
                 A.1.1.
                 <tab/>
                 Annex A.1a
               </title>
             </clause>
           </clause>
         </annex>
         <bibliography>
           <references id='R' obligation='informative' normative='true'>
             <title depth='1'>
               1.
               <tab/>
               Normative References
             </title>
           </references>
           <clause id='S' obligation='informative'>
             <title depth='1'>Bibliography</title>
             <references id='T' obligation='informative' normative='false'>
               <title depth='2'>Bibliography Subsection</title>
             </references>
           </clause>
         </bibliography>
       </vsd-standard>
    OUTPUT
    stripped_html = xmlpp(IsoDoc::VG::PresentationXMLConvert
                          .new({})
                          .convert('test', input, true))
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

    expect(xmlpp(Asciidoctor.convert(input, backend: :vg, header_footer: true))).to be_equivalent_to output
    html = File.read("test.html", encoding: "utf-8")
    expect(html).to match(%r{jquery\.min\.js})
    expect(html).to match(%r{Overpass})
  end

end

