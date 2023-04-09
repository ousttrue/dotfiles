- [Gtk – 4.0: Migrating from GTK 3.x to GTK 4](https://docs.gtk.org/gtk4/migrating-3to4.html#stop-using-gtkwidget-event-signals)

[[GTK3]]

```python
	def on_motion(self, widget, event):
		pass
	self.add_events(Gdk.EventMask.POINTER_MOTION_MASK)
	self.connect("motion-notify-event", self.on_motion)
```

👇

[[GTK4]]
```python
	def on_motion(self, controller, x, y):
		pass
	controller = Gtk.EventControllerMotion()
	controller.connect('motion', self.on_motion)
	self.add_controller(controller)
```
