<script>
  import { mapActions, mapState } from 'vuex';
  import { __ } from '../../../locale';
  import modal from '../../../vue_shared/components/modal.vue';

  export default {
    components: {
      modal,
    },
    props: {
      branchId: {
        type: String,
        required: true,
      },
      parent: {
        type: Object,
        default: null,
      },
      type: {
        type: String,
        required: true,
      },
      path: {
        type: String,
        required: true,
      },
    },
    data() {
      return {
        entryName: this.path !== '' ? `${this.path}/` : '',
      };
    },
    computed: {
      ...mapState([
        'currentProjectId',
      ]),
      modalTitle() {
        if (this.type === 'tree') {
          return __('Create new directory');
        }

        return __('Create new file');
      },
      buttonLabel() {
        if (this.type === 'tree') {
          return __('Create directory');
        }

        return __('Create file');
      },
      formLabelName() {
        if (this.type === 'tree') {
          return __('Directory name');
        }

        return __('File name');
      },
    },
    mounted() {
      this.$refs.fieldName.focus();
    },
    methods: {
      ...mapActions([
        'createTempEntry',
      ]),
      createEntryInStore() {
        this.createTempEntry({
          projectId: this.currentProjectId,
          branchId: this.branchId,
          parent: this.parent,
          name: this.entryName.replace(new RegExp(`^${this.path}/`), ''),
          type: this.type,
        });

        this.hideModal();
      },
      hideModal() {
        this.$emit('hide');
      },
    },
  };
</script>

<template>
  <modal
    :title="modalTitle"
    :primary-button-label="buttonLabel"
    kind="success"
    @cancel="hideModal"
    @submit="createEntryInStore"
  >
    <form
      class="form-horizontal"
      slot="body"
      @submit.prevent="createEntryInStore"
    >
      <fieldset class="form-group append-bottom-0">
        <label class="label-light col-sm-3">
          {{ formLabelName }}
        </label>
        <div class="col-sm-9">
          <input
            type="text"
            class="form-control"
            v-model="entryName"
            ref="fieldName"
          />
        </div>
      </fieldset>
    </form>
  </modal>
</template>
