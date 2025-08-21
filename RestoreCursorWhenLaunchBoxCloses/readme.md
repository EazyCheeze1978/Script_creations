# "Cursor Commander" (thanks for the cheese there, ChatGPT)

## A very small utility, in rudimentary form so far, for accessibility-minded users

I'm most definitely a classic emulation fan. So, it goes without saying that I use [LaunchBox](https://launchbox-app.com/) on the regular.

LB, and it's big-screen cousin BigBox (BB), however, currently have an issue regarding accessibility - so, with the aid of ChatGPT 4o and inspired by chats on Discord, I've come up with a workaround.

### The issue

When LaunchBox or BigBox run an emulator, they hide the mouse cursor from view. (Now, we can select to SHOW it on the Startup screens that they support, but that is separate from the main hiding operation) When the emulator exits, the mouse cursor is brought back -

but in a state which is unaware of any high-DPI settings that a user may have made in the Display settings in Windows. So, it appears fairly blocky/blown-up compared to the normal look of the cursor.

The biggest issue occurs when the user exits LaunchBox or BigBox, and the processes clean themselves up and exit. The mouse cursor reverts to an extremely small size, again ignoring DPI changes - this phenomenon apparently is not solved by setting the compatibility option "Override High DPI scaling behavior. Scaling performed by (select from drop-down) Application [or] System."

Obviously the tiny size can be gotten used to, but the user shouldn't have to do so - so this little script now exists.

This script watches for the LaunchBox or BigBox process to close - when it does, it restores the "Windows Default (system scheme)" mouse cursor scheme and exits itself. This works quite reliably now, but the one scheme is the only one supported for now - am looking to expand capabilities/add a UI if necessary.

I hope this helps people like me who have issues with eyestrain or have set High DPI settings in Windows for any reason! Please make any suggestions you may have - I am not really a programmer and this has been done out of personal necessity, but I'm always willing to help the community when I'm able.

Thank you! Take care.