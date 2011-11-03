package {
import Box2D.Common.Math.*;
import Box2D.Dynamics.*;



public class AI {
	public var goal_pos:b2Vec2 = new b2Vec2(9,5);
	public var goal_vel:b2Vec2 = new b2Vec2(0,0);
	
	public var max_force;
	public var mass;
	public var P, D;
	
	
	public function AI(b:b2Body, p=1, d=1) {
		mass = b.GetMass();
		max_force = 2*(mass*10); // Gravity is +10 (downwards)
		// the 2 in 2*(mass*10) means twice the downward force due to weight
		P = p*max_force;
		D = d*max_force;
		/// Make P / D a ratio
	}
	
	public function setPID(p,d) {
		P = p*max_force;
		D = d*max_force;
	}
	
	public function SetGoalPos(x,y) {
		goal_pos.Set(x,y);
	}
	public function step(b:b2Body) {
		//trace(bod.GetWorldCenter().y);
		// If past min_height since y increases downwards
		//if (b.GetWorldCenter().y > goal_height) {
			// move up
			return hover(b);
		//}
	}
	// Hover at (or above?) minimum height
	public function hover(b:b2Body) {
		var dx = goal_pos.x - b.GetWorldCenter().x;
		var ddx = goal_vel.x - b.GetLinearVelocity().x;
		
		var dy = goal_pos.y - b.GetWorldCenter().y;
		var ddy = goal_vel.y - b.GetLinearVelocity().y;
		
		var fx = (P*dx) + (D*ddx);
		var fy = (P*dy) + (D*ddy);
		
		// clip to maximum force
		
		// These will clip rectangle, so maybe total force > max_force
		/*if (fx > max_force) { fx = max_force; }
		if (-fx > max_force) { fx = -max_force; }
		if (fy > max_force) { fy = max_force; }
		if (-fy > max_force) { fy = -max_force; }
		*/
		var f = new b2Vec2(fx,fy);
		
		// This will clip circle, total force <= max_force
		if (f.Length() > max_force) {
			f.Normalize();
			f.Multiply(max_force);
		}
		//f.MinV(new b2Vec2(max_force,max_force) );
		//f.MaxV(new b2Vec2(-max_force,-max_force) );
		
		//fy = -fy; // Up direction is negative
		b.ApplyForce( f, b.GetWorldCenter() );
		//trace('Pushing up!');
		return f;
	}
} // end class AI

} // end package