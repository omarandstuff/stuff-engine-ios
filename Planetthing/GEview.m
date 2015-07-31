#import "GEview.h"

@interface GEView()
{
    GEContext* m_context;
    GEFBO* m_fbo;
    
    GEFullScreen* m_fullScreen;
    
    GLuint character;
    
    FT_Library  m_library;
}

@end

@implementation GEView

@synthesize BackgroundColor;
@synthesize Opasity;
@synthesize Layers;

// ------------------------------------------------------------------------------ //
// -------------------------- Initialization and Set up ------------------------- //
// ------------------------------------------------------------------------------ //
#pragma mark Initialization and Set up

- (id)init
{
    self = [super init];
    
    if(self)
    {
        // Get the context
        m_context = [GEContext sharedIntance];
        
        // Layers
        Layers = [NSMutableDictionary new];
        
        // Opaque background.
        Opasity = 1.0f;
        
        // FBO
        m_fbo = [GEFBO new];
        [m_fbo geberateForWidth:640 andHeight:960];
        
        // Full Screen
        m_fullScreen = [GEFullScreen new];
        
        if (FT_Init_FreeType( &m_library ))
        {
            // Error
        }
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"arial" ofType:@"ttf"];
        
        FT_Face face;
        
        if (FT_New_Face(m_library, [path UTF8String], 0, &face))
        {
            return self;
        }
        
        FT_Select_Charmap(face , ft_encoding_unicode);
        
        FT_Set_Pixel_Sizes(face, 0, 1000);
        
        if (FT_Load_Char(face, 290, FT_LOAD_RENDER))
        {
            return self;
        }
        
        GLuint width = face->glyph->bitmap.width;
        GLuint height = face->glyph->bitmap.rows;
        
        
        unsigned char* bufferGlyph = face->glyph->bitmap.buffer;
        
        glGenTextures(1, &character);
        glBindTexture(GL_TEXTURE_2D, character);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_ALPHA, width, height, 0, GL_ALPHA, GL_UNSIGNED_BYTE, bufferGlyph);
        // Set texture options
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
        
        FT_Done_Face(face);
        FT_Done_FreeType(m_library);
        
    }
    
    return self;
}

// ------------------------------------------------------------------------------ //
// ------------------------------------ Render ---------------------------------- //
// ------------------------------------------------------------------------------ //
#pragma mark Render

- (void)render
{
    //glBindFramebuffer(GL_FRAMEBUFFER, m_fbo.FrameBufferID);
    
    [m_context setBackgroundColor:GLKVector4MakeWithVector3(BackgroundColor, Opasity)];
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    
    for(NSString* layer in Layers)
    {
        [Layers[layer] render];
    }
    
    
    [m_context.ContextView bindDrawable];
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    m_fullScreen.TextureID = character;
    [m_fullScreen render];
}

// ------------------------------------------------------------------------------ //
// ----------------------------------- Layers ----------------------------------- //
// ------------------------------------------------------------------------------ //
#pragma mark Layers

- (GELayer*)addLayerWithName:(NSString*)name
{
    if([Layers objectForKey:name] != nil) return nil;
    
    GELayer* newLayer = [GELayer new];
    newLayer.Name = name;
    
    [Layers setObject:newLayer forKey:name];
    
    return newLayer;
}

- (void)addLayerWithLayer:(GELayer*)layer
{
    GELayer* currentLayer = [Layers objectForKey:layer.Name];
    if(currentLayer == nil)
        [Layers setObject:layer forKey:layer.Name];
}

- (GELayer*)getLayerWithName:(NSString*)name
{
    return [Layers objectForKey:name];
}

- (void)removeLayerWithName:(NSString*)name
{
    [Layers removeObjectForKey:name];
}

- (void)removeLayer:(GELayer*)layer
{
    [Layers removeObjectForKey:layer.Name];
}

// ------------------------------------------------------------------------------ //
// ------------------------------ Setters - Getters ----------------------------- //
// ------------------------------------------------------------------------------ //
#pragma mark Setters - Getters


@end
