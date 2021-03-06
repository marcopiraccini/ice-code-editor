part of ice;

class RemoveDialog extends Dialog implements MenuAction {
  RemoveDialog(Full f): super(f);

  get name => "Remove";

  open() {
    var message = '''
      Remove: ${store.currentProjectTitle}.

      Once this project is removed, you will not be
      able to get it back.

      Are you sure you want to remove this project?''';

    if (Notify.confirm(message, parent: parent)) _removeCurrentProject();
  }

  _removeCurrentProject() {
    var title = store.currentProjectTitle;
    store.remove(title);

    title = store.currentProjectTitle;
    ice.content = (title == 'Untitled') ?
      DefaultProject.content : store[title]['code'];
  }
}
