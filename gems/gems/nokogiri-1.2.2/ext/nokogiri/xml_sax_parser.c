#include <stdio.h>
#include <xml_sax_parser.h>

/*
 * call-seq:
 *  parse_memory(data)
 *
 * Parse the document stored in +data+
 */
static VALUE parse_memory(VALUE self, VALUE data)
{
  xmlSAXHandlerPtr handler;
  Data_Get_Struct(self, xmlSAXHandler, handler);
  xmlSAXUserParseMemory(  handler,
                          (void *)self,
                          StringValuePtr(data),
                          RSTRING_LEN(data)
  );
  return data;
}

/*
 * call-seq:
 *  native_parse_io(data, encoding)
 *
 * Parse the document accessable via +io+
 */
static VALUE native_parse_io(VALUE self, VALUE io, VALUE encoding)
{
  xmlSAXHandlerPtr handler;
  Data_Get_Struct(self, xmlSAXHandler, handler);

  xmlCharEncoding enc = (xmlCharEncoding)NUM2INT(encoding); 

  xmlParserCtxtPtr sax_ctx = xmlCreateIOParserCtxt(
      handler,
      (void *)self,
      (xmlInputReadCallback)io_read_callback,
      (xmlInputCloseCallback)io_close_callback,
      (void *)io,
      enc
  );
  xmlParseDocument(sax_ctx);
  xmlFreeParserCtxt(sax_ctx);
  return io;
}

/*
 * call-seq:
 *  native_parse_file(data)
 *
 * Parse the document stored in +data+
 */
static VALUE native_parse_file(VALUE self, VALUE data)
{
  xmlSAXHandlerPtr handler;
  Data_Get_Struct(self, xmlSAXHandler, handler);
  xmlSAXUserParseFile(  handler,
                        (void *)self,
                        StringValuePtr(data)
  );
  return data;
}

static void start_document(void * ctx)
{
  VALUE self = (VALUE)ctx;
  VALUE doc = rb_funcall(self, rb_intern("document"), 0);
  rb_funcall(doc, rb_intern("start_document"), 0);
}

static void end_document(void * ctx)
{
  VALUE self = (VALUE)ctx;
  VALUE doc = rb_funcall(self, rb_intern("document"), 0);
  rb_funcall(doc, rb_intern("end_document"), 0);
}

static void start_element(void * ctx, const xmlChar *name, const xmlChar **atts)
{
  VALUE self = (VALUE)ctx;
  VALUE doc = rb_funcall(self, rb_intern("document"), 0);
  VALUE attributes = rb_ary_new();
  VALUE MAYBE_UNUSED(enc) = rb_iv_get(self, "@encoding");
  const xmlChar * attr;
  int i = 0;
  if(atts) {
    while((attr = atts[i]) != NULL) {
      rb_funcall(attributes, rb_intern("<<"), 1,
          NOKOGIRI_STR_NEW2(attr, RTEST(enc) ? StringValuePtr(enc) : NULL)
      );
      i++;
    }
  }

  rb_funcall( doc,
              rb_intern("start_element"),
              2,
              NOKOGIRI_STR_NEW2(name, RTEST(enc) ? StringValuePtr(enc) : NULL),
              attributes
  );
}

static void end_element(void * ctx, const xmlChar *name)
{
  VALUE self = (VALUE)ctx;
  VALUE MAYBE_UNUSED(enc) = rb_iv_get(self, "@encoding");
  VALUE doc = rb_funcall(self, rb_intern("document"), 0);
  rb_funcall(doc, rb_intern("end_element"), 1,
      NOKOGIRI_STR_NEW2(name, RTEST(enc) ? StringValuePtr(enc) : NULL)
  );
}

static void characters_func(void * ctx, const xmlChar * ch, int len)
{
  VALUE self = (VALUE)ctx;
  VALUE MAYBE_UNUSED(enc) = rb_iv_get(self, "@encoding");
  VALUE doc = rb_funcall(self, rb_intern("document"), 0);
  VALUE str = NOKOGIRI_STR_NEW(ch, len, RTEST(enc) ? StringValuePtr(enc):NULL);
  rb_funcall(doc, rb_intern("characters"), 1, str);
}

static void comment_func(void * ctx, const xmlChar * value)
{
  VALUE self = (VALUE)ctx;
  VALUE MAYBE_UNUSED(enc) = rb_iv_get(self, "@encoding");
  VALUE doc = rb_funcall(self, rb_intern("document"), 0);
  VALUE str = NOKOGIRI_STR_NEW2(value, RTEST(enc) ? StringValuePtr(enc):NULL);
  rb_funcall(doc, rb_intern("comment"), 1, str);
}

static void warning_func(void * ctx, const char *msg, ...)
{
  VALUE self = (VALUE)ctx;
  VALUE doc = rb_funcall(self, rb_intern("document"), 0);
  VALUE MAYBE_UNUSED(enc) = rb_iv_get(self, "@encoding");
  char * message;

  va_list args;
  va_start(args, msg);
  vasprintf(&message, msg, args);
  va_end(args);

  rb_funcall(doc, rb_intern("warning"), 1,
      NOKOGIRI_STR_NEW2(message, RTEST(enc) ? StringValuePtr(enc) : NULL)
  );
  free(message);
}

static void error_func(void * ctx, const char *msg, ...)
{
  VALUE self = (VALUE)ctx;
  VALUE MAYBE_UNUSED(enc) = rb_iv_get(self, "@encoding");
  VALUE doc = rb_funcall(self, rb_intern("document"), 0);
  char * message;

  va_list args;
  va_start(args, msg);
  vasprintf(&message, msg, args);
  va_end(args);

  rb_funcall(doc, rb_intern("error"), 1,
      NOKOGIRI_STR_NEW2(message, RTEST(enc) ? StringValuePtr(enc) : NULL)
  );
  free(message);
}

static void cdata_block(void * ctx, const xmlChar * value, int len)
{
  VALUE self = (VALUE)ctx;
  VALUE MAYBE_UNUSED(enc) = rb_iv_get(self, "@encoding");
  VALUE doc = rb_funcall(self, rb_intern("document"), 0);
  VALUE string =
    NOKOGIRI_STR_NEW(value, len, RTEST(enc) ? StringValuePtr(enc) : NULL);
  rb_funcall(doc, rb_intern("cdata_block"), 1, string);
}

static void deallocate(xmlSAXHandlerPtr handler)
{
  NOKOGIRI_DEBUG_START(handler);
  free(handler);
  NOKOGIRI_DEBUG_END(handler);
}

static VALUE allocate(VALUE klass)
{
  xmlSAXHandlerPtr handler = calloc(1, sizeof(xmlSAXHandler));

  handler->startDocument = start_document;
  handler->endDocument = end_document;
  handler->startElement = start_element;
  handler->endElement = end_element;
  handler->characters = characters_func;
  handler->comment = comment_func;
  handler->warning = warning_func;
  handler->error = error_func;
  handler->cdataBlock = cdata_block;

  return Data_Wrap_Struct(klass, NULL, deallocate, handler);
}

VALUE cNokogiriXmlSaxParser ;
void init_xml_sax_parser()
{
  VALUE nokogiri  = rb_define_module("Nokogiri");
  VALUE xml       = rb_define_module_under(nokogiri, "XML");
  VALUE sax       = rb_define_module_under(xml, "SAX");
  VALUE klass     = rb_define_class_under(sax, "Parser", rb_cObject);

  cNokogiriXmlSaxParser = klass;

  rb_define_alloc_func(klass, allocate);
  rb_define_method(klass, "parse_memory", parse_memory, 1);
  rb_define_private_method(klass, "native_parse_file", native_parse_file, 1);
  rb_define_private_method(klass, "native_parse_io", native_parse_io, 2);
}
