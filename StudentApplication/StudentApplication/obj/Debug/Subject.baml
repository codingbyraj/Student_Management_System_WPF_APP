   M S B A M L   `   `   `  ����M  IStudentApplication, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null7 clr-namespace:StudentApplicationStudentApplication  5           StudentApplication.Subject   5      R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5      R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5      Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5      @d2http://schemas.microsoft.com/expression/blend/2008     5      c _System.Windows.Interactivity, Version=4.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35Bi:http://schemas.microsoft.com/expression/2010/interactivity  5      ,local clr-namespace:StudentApplication  5        N� Title$  Subject��5      .��5      � .+�5   
   ��  �� Orientation$ Vertical=�6   .+�5      �� $��0 30 0 5q�6   .+�5      �� �� 5      -   5        $��btnSave��5      $
��Save��5      $��Century Gothic)�6$   
�������
��� � �
��� � �$��1q�5      $��30, 5q�6)   $
��0, 5q�5      $
��Left=�6#   ��6>   �� *OnSubjectSaveCommand+ � 	Resources 5       �� 
TargetType �� Property �� Value �� Triggers P� Property P� Value��%�   '��       �� 5      " ��6    .�5      ��  �@��CornerRadius$ 10��6=   �� 5       �@�Cursor$
 Hand��67    5      P� 5   "    �@J�IsMouseOver . . �5   &   ��  � ��
 ��d�6C   5   #   5      5       5!       �� 5"      -   5        $��	btnDelete��5#      $��Delete��5$      $��Century Gothic)�6&   
���  ��
�������
���  ��$��1q�5&      $��30, 5q�6)   $
��0, 5q�5'      $
��Left=�6#   ��6>   �� *OnSubjectDeleteCommand+ 5(      ��%�   '��       �� 5)      " ��6    .�5*      ��  �@��CornerRadius$ 10��6=   �� 5+       �@�Cursor$
 Hand��67    5,      P� 5-   "    �@J�IsMouseOver . . �5.   &   ��  � ��
 �  ��6C   5/   #   51      52      53       �� 55      -   5        $��btnDeleteBlank��56      $��Delete Blank��57      $��Century Gothic)�6,   
�������
��� � �
��� � �$��1q�59      $��30, 5q�6)   $
��0, 5q�5:      $
��Left=�6#   ��6>   �� *OnDeleteBlankRowCommand+ 5;      ��%�   '��       �� 5<      " ��6    .�5=      ��  �@��CornerRadius$ 10��6=   �� 5>       �@�Cursor$
 Hand��67    5?      P� 5@   "    �@J�IsMouseOver . . �5A   &   ��  � ��
 ��d�6C   5B   #   5D      5E      5F      5G      5H      �� 5I      .+�5J      � 	 � ColumnDefinitions	 5K      �� 5L      $��* �6+   �� 5M      $��* �6+   �� 5N      $��* �6+   5P      &   System.Windows.Controls.DataGrid  5Q      -   5        $��	dgSubject��5Q      
   AutoGenerateColumns
 .  $	��515��6H   $��Center=�6U   $��Center=�6p      CanUserAddRows . ��. $��Visible=�5T   6      SelectionUnit$ FullRow=�5U   G   $ �� IsSynchronizedWithCurrentItem$
 TrueY�6_      SelectionMode$ Extended=�5V      !   EnableColumnVirtualization . ��5S      �� *subjectList+ �� Mode$ TwoWay=� �� UpdateSourceTrigger$ PropertyChanged=� �� NotifyOnSourceUpdated .  �� SelectedItem 5U      �� *SelectedSubject+$ TwoWay=�   Columns 5X      0  *System.Windows.Controls.DataGridTextColumn  5Z         	FontStyle$ Normal$�6-      FontSize$ 16Q�6@   ,  &System.Windows.Controls.DataGridColumn   Width5  /System.Windows.Controls.DataGridLengthConverter$ * 6O      Header$
 Name��6Y   1  +System.Windows.Controls.DataGridBoundColumn   Binding 6g   �� *Name+4  .System.Windows.Controls.DataGridTemplateColumn  5]      $ Subject Category��61   $ * 6K      SortMemberPath$ SubjectCategoryName��6U      CanUserSort .    CellTemplate 5^      �� 5_   "   .R�5`   &   �� $��Center=�60   $��Center=�6M   $��16(�6h   $��25��6v   ��6�   �� *SubjectCategoryName+6�   5a   #      CellEditingTemplate 5c      �� 5d   "   .R�5e   &   �� $��25��6/   $��16(�6<    �� DisplayMemberPath$
 Name��5h   =    �� SelectedValuePath$ Id��5i   =   ��5e   J   �� *DataContext.SubjectNameAndId+  �� RelativeSource  �� *FindAncestor+! �� AncestorType"!  " �� SelectedValue" 5j   /   �� *SubjectCategoryId+5k   '   5l   #   5n        5q      $ Status��61   $ * 6A    5r      �� 5s   "   .R�5t   &   �� $��Center=�60   $��Center=�6M   $��16(�6h   $��25��6v   ��6�   �� *Status+5u   '   5v   #    5x      �� 5y   "   .R�5z   &   �� # �� Text$# 
--Select--��6/   $��16(�6A   $��25��6O   ��5{   /   �� *DataContext.statusList+  �� *FindAncestor+"!   5}   /   �� *Status+6Q   5~   #   5�      5�      5�      5�      5�      5�      