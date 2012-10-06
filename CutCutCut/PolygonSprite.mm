//
//  PolygonSprite.m
//  CutCutCut
//
//  Created by mac on 12-9-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PolygonSprite.h"


@implementation PolygonSprite

@synthesize body=_body;
@synthesize original=_original;
@synthesize centroid=_centroid;

+(id)spriteWithFile:(NSString *)filename body:(b2Body *)body original:(BOOL)original{
    return [[[self alloc]initWithFile:filename body:body original:original]autorelease];
}

+(id)spriteWithTexture:(CCTexture2D *)texture body:(b2Body *)body original:(BOOL)original{
    return [[[self alloc]initWithTexture:texture body:body original:original]autorelease];
}

+(id)spriteWIthWorld:(b2World *)world{
    return [[[self alloc]initwithWorld:world]autorelease];
}

-(id)initWithTexture:(CCTexture2D *)texture body:(b2Body *)body original:(BOOL)original{
    b2Fixture *originalFixture=body->GetFixtureList();
    b2PolygonShape *shape=(b2PolygonShape*)originalFixture->GetShape();
    int vertexCount=shape->GetVertexCount();
    NSMutableArray *points=[NSMutableArray arrayWithCapacity:vertexCount];
    for(int i=0;i<vertexCount;i++){
        CGPoint p=ccp(shape->GetVertex(i).x*PTM_RATIO,shape->GetVertex(i).y*PTM_RATIO);
        [points addObject:[NSValue valueWithCGPoint:p]];
    }
    
    if(self=[super initWithPoints:points andTexture:texture]){
        _body=body;
        _body->SetUserData(self);
        _original=original;
        
        _centroid=self.body->GetLocalCenter();
        
        self.anchorPoint=ccp(_centroid.x*PTM_RATIO/texture.contentSize.width,
                             _centroid.y*PTM_RATIO/texture.contentSize.height);
        
    }
    return self;
}

-(id)initwithWorld:(b2World *)world{
    return nil;
}

@end
