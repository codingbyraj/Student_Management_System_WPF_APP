   M S B A M L   `   `   `  ����M  IStudentApplication, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null7 clr-namespace:StudentApplicationStudentApplication  5   	   !    StudentApplication.Register   5   	   R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   2local clr-namespace:StudentApplication     5   	     � Title$  Register��5   	   $	��587��6   $	��300��6'    � WindowState$ 	Maximized=�63   .��5	      � .+�5
   
   ��  �� Padding$ 10q�6   
���   �._�5      �� 
���   �$��1q�6)   $ 10q�6=   ._�5      �� $��0 40 0 0q�6   ._�5      ��  �� Orientation$ Vertical=�6!   .+�5      �� 
����+��.+�5      �� -   5        $��textBlockHeading��5   b   $��23��6(   $
��Left=�64   $��	10,5,0,10q�6O   $��Register��5      $	��Top=�6$   $	��110��6<   $��17(�6I   $��ExtraCondensed&�6W   
�������6t   5      �� 5      
�������.+�5      �� $��	_UserName��6$    �� Target 68   ��  �� ElementName$ txtEmail��6b   �� 5      -   5        $��txtEmail��5   2   $��30��6&   62   �� 5      $��	_Password��6$    68   �� $ txtPassword��6e   G� 5      -   5        $��txtPassword��5   6   $��30��6*   66   �� 5      $��_Re-Enter Password��6$    6A   �� $ txtRePassword��6p   G� 5      -   5        $��txtRePassword��5   6   $��30��6*   66   �� 5       �� TextAlignment$ Center=�6(   $��0 20 0 0q�6?   �� 5      -   5        $��btnRegister��5       $��Click for Register��5   %   $��30��6B   $
��10 0q�6N   
�������
��� � �
��� � ���5!      �� *OnSaveUserCommand+ �� 5$      -   5        $��btnReset��5$   A   $��Reset��6%   $��30��65   $
��10 0q�6Q   
�������
���  ��
���  ��5%   %   5&      �� 5'      $
��0 20q�6(   $ Center=�66   Already Registered? �� 6b   -   5         �Name$ btnLoginLink��5'   l   .�6�   
click here6�   6�   5(      5)      5*      5+      5,      5-      5.      