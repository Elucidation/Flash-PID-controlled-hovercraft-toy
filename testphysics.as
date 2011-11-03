package
{
import flash.display.Sprite;
import flash.events.Event;
import Box2D.Dynamics.*;
import Box2D.Collision.*;
import Box2D.Collision.Shapes.*;
import Box2D.Common.Math.*;

public class testphysics extends Sprite
{
	public function testphysics()
	{
		// Add event for main loop
		addEventListener(Event.ENTER_FRAME, Update, false, 0, true);
		
		// Creat world AABB
		var worldAABB:b2AABB = new b2AABB();
		worldAABB.lowerBound.Set(-100.0, -100.0); // 1m = 30pixels
		worldAABB.upperBound.Set(100.0, 100.0);
		
		// Define the gravity vector
		var gravity:b2Vec2 = new b2Vec2(0.0, 10.0);
		
		// Allow bodies to sleep
		var doSleep:Boolean = true;
		
		// Construct a world object
		var m_world:b2World = new b2World(worldAABB, gravity, doSleep);
		
		
		// Define shape
		var boxDef:b2PolygonDef = new b2PolygonDef();
		boxDef.SetAsBox(3,1); // 90px by 30px
		boxDef.friction = 0.3;
		
		// Define body
		var bodyDef:b2BodyDef = new b2BodyDef();
		bodyDef.userData = new Sprite();
		bodyDef.userData.width = 90;
		bodyDef.userData.height = 30;
		bodyDef.position.Set(5.5,10); // meters, x=165, y=300
		
		addChild(bodyDef.userData);
		
		var body:b2Body = m_world.CreateStaticBody(bodyDef);
		body.CreateShape(boxDef);
		body.SetMassFramShape();
		
		
		
	}
	private function Update(e:Event) {
		m_world.Step(1,1);
	}
}
}
